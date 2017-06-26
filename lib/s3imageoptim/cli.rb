require "thor"
require "s3imageoptim/command"

class S3imageoptim::CLI < Thor

  register S3imageoptim::Command, "optim", "optim BUCKET", "Get all files from a S3 BUCKET and put them back compressed"

  private
  def exit_on_failure?
    true
  end
end
