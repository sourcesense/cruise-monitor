require 'rake'
require 'rake/testtask'
require 'script/rake_utils'
require 'script/deploy_instance'

CONFIG_FILE = 'script/config.rb'
require_if_exists(CONFIG_FILE)

task :default => :'test:all'

desc 'Perform monitoring'
task :monitor do
  begin
    monitor = CruiseMonitor::Config::MONITOR
    monitor.sync
  rescue NameError
    puts "Please, configure Cruise-monitor running:"
    puts "  rake init"
    puts "Then edit '#{CONFIG_FILE}' file"
  end
end

desc 'Initialize configuration'
task :init do
  FileUtils.copy("#{CONFIG_FILE}.example", CONFIG_FILE)
  puts "Please, edit '#{CONFIG_FILE}' file"
end

desc 'Clean build info'
task :clean do
  monitor = CruiseMonitor::Config::MONITOR
  File.delete(monitor.storage_path)
end

namespace :test do
  desc 'Run all tests'
  task :all => [ :unit, :integration, :acceptance ]
  
  Rake::TestTask.new(:integration) do |t|
    t.libs = ["test"] # so far, 'lib' sets monitor.rb in conflict with ruby dist
    t.test_files = FileList['test/integration/**/*_test.rb']
    t.verbose = false
  end

  Rake::TestTask.new(:acceptance) do |t|
    t.libs << "test"
    t.test_files = FileList['test/acceptance/**/*_test.rb']
    t.verbose = false
  end

  Rake::TestTask.new(:unit) do |t|
    t.libs << "test"
    t.test_files = FileList['test/unit/**/*_test.rb']
    t.verbose = false
  end
end

desc 'Deploy on remote EC2 instances'
task :deploy do
  options = {
    :host => 'www.cruise-monitor.tk',
    :user => 'ubuntu',
    :credentials => "#{ENV['HOME']}/.ec2/build.pem"
  }
  
  instance = CruiseMonitor::DeployInstance.new(options)
  instance.execute_remotely('server/script/remote_deploy_commands.sh')
end