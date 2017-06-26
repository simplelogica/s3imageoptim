require "open3"

module S3CmdHelpers

  def make_bucket
    s3cmd("mb s3://s3_imageoptim")
  end

  def remove_bucket
    s3cmd("rb s3://s3_imageoptim")
  end

  def uploaded_file_size(fixture)
    # s3cmd "du" command won't work here
    # See: https://github.com/jubos/fake-s3/issues/168
    Dir.mktmpdir do |path|
      s3cmd("get #{bucket}/#{fixture[:path]} #{path}")
      File.size("#{path}/#{File.basename(fixture[:path])}")
    end
  end

  def s3cmd(args, verbose: false)
    Open3.popen3("s3cmd -v #{args}") do |stdin, stdout, stderr, thread|
      if verbose
        puts "s3cmd #{args}"
        puts stdout.read
        puts stderr.read
      else
        stdout.read
      end
    end
  end
end

RSpec.configure do |c|
  c.include S3CmdHelpers
end
