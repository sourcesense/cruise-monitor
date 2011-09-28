require 'rake'
require 'rake/testtask'
require 'script/ec2_instance'

task :default => :'test:all'

desc 'Deploy on remote EC2 instances'
task :deploy do
  options = {
    :host => 'www.cruise-monitor.tk',
    :user => 'ubuntu',
    :key => "#{ENV['HOME']}/.ec2/build.pem"
  }
  
  ec2 = Ec2Instance.new(options)
  ec2.execute_remotely('server/script/remote_deploy_commands.sh')
end

namespace :test do 
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