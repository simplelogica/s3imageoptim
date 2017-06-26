module FixturesHelper
  def path_for(file)
    File.join(File.dirname(__FILE__), 'fixtures', file)
  end

  def upload(filename, path = nil)
    path ||= filename
    @uploaded_fixtures << {filename: filename, path: path}
    s3cmd("put #{path_for(filename)} #{bucket}/#{path}")
  end

  def delete_uploaded_fixtures
    # FIXME Somehow can't delete recursively

    @uploaded_fixtures.each do |f|
      s3cmd("del #{bucket}/#{f[:path]}")
    end

    # Delete folders
    @uploaded_fixtures.map { |f| File.dirname(f[:path]) }.uniq.each do |path|
      next if path == "."
      s3cmd("del #{File.join(bucket, path)}")
    end

    @uploaded_fixtures = []
  end

  def fixture_size(fixture)
    File.size(path_for(fixture[:filename]))
  end

  def self.included(base)
    base.let(:uploaded_fixtures) { @uploaded_fixtures }

    base.before do
      @uploaded_fixtures = []
    end

    base.after do
      delete_uploaded_fixtures
    end
  end
end

RSpec.configure do |c|
  c.include FixturesHelper
end
