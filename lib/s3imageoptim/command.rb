require "thor/group"
require "s3imageoptim"
require "image_optim"
require "open3"

class S3imageoptim::Command < Thor::Group
  argument :bucket, desc: "S3 Bucket to compress"
  class_option :acl, enum: %w(public private), default: "public"

  desc "Get all files from BUCKET and put them back compressed"
  def get
    s3cmd("get --exclude '*' --rinclude '\.(#{extensions("|")})$' --recursive #{bucket} #{tmpdir}") do |error|
      abort("An error ocurred while getting the files: #{error}")
    end

    if local_files.empty?
      abort("No images were found in the bucket")
    end
  end

  def compress
    ImageOptim.new(
      svgo: false,
      pngout: false,
      jpegoptim: {
        allow_lossy: true,
        max_quality: 80
      }
    ).optimize_images!(local_files)
  end

  def put
    s3cmd("sync --acl-#{options[:acl]} #{tmpdir}/ #{bucket}") do |error|
      abort("An error ocurred while putting the files: #{error}")
    end
  end

  def remove
    FileUtils.remove_entry(tmpdir)
  end

  private
  def local_files
    Dir.glob(File.join(tmpdir, "**", "*.{#{extensions(",")}}"))
  end

  def extensions(separator)
    %w{jpg jpeg png}.join(separator)
  end

  def tmpdir
    @tmpdir ||= Dir.mktmpdir
  end

  def s3cmd(args, &failure_block)
    Open3.popen3("s3cmd #{args}") do |stdin, stdout, stderr, thread|
      thread.value.success? ? stdout.read : failure_block.call(stderr.read)
    end
  end
end
