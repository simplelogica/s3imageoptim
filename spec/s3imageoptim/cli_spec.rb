require 'spec_helper'
require 's3cmd_helper'
require 'fixtures_helper'
require "s3imageoptim/cli"

describe S3imageoptim::CLI do
  let(:bucket) { "s3://#{bucket_name}"}
  let(:bucket_name) { "s3_imageoptim" }

  before do
    make_bucket
  end

  after do
    delete_uploaded_fixtures
    remove_bucket
  end

  describe "called without arguments" do
    it "complains" do
      expect { S3imageoptim::CLI.new.optim }.to raise_error(Thor::RequiredArgumentMissingError)
    end
  end

  describe "when called with an argument" do
    subject { S3imageoptim::CLI.new.optim(bucket) }

    describe "but getting the files fails" do
      let(:bucket_name) { "empty_bucket"}

      it "shows an error" do
        expect { subject }.to raise_error(SystemExit).and output(/An error ocurred while getting the files/).to_stderr
      end
    end

    describe "and there are no files" do
      it "notifies about it" do
        expect { subject }.to raise_error(SystemExit).and output(/No images were found in the bucket/).to_stderr
      end
    end

    describe "and there are files but no images" do
      before do
        upload("file.txt")
      end

      it "notifies about it" do
        expect { subject }.to raise_error(SystemExit).and output(/No images were found in the bucket/).to_stderr
      end
    end

    describe "and there are images even in folders, " do
      before do
        upload("test.jpg", "test.jpeg")
        upload("test.jpg", "subdir/test.jpg")
        upload("test.png", "another/test.png")
      end

      it "compresses them and puts them back" do
        expect { subject }.not_to raise_error
        expect(uploaded_fixtures.count).to be == 3

        uploaded_fixtures.each do |fixture|
          expect(fixture_size(fixture)).to be > uploaded_file_size(fixture)
        end
      end
    end
  end
end
