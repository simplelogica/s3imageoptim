require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

desc "Run the fake s3 server"
task :s3_server do
  trap("SIGINT") {
    puts "Restoring original s3cmd config..."
    FileUtils.cp("#{Dir.home}/.s3cfg.original", "#{Dir.home}/.s3cfg") rescue Errno::ENOENT
  }

  Dir.mktmpdir do |dir|
    FileUtils.cp("#{Dir.home}.s3cfg", "#{Dir.home}/.s3cfg.original") rescue Errno::ENOENT
    FileUtils.cp("s3cfg", "#{Dir.home}/.s3cfg")
    system("bundle exec bin/fakes3 --port 12345 --root #{dir}")
  end
end
