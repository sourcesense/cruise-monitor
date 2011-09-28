require 'rubygems'
require 'net/ssh'

class Ec2Instance

  def initialize(options)
    @host = options[:host]
    @user = options[:user]
    @ec2_key = options[:key]
  end

  def execute_remotely(file)
    if ! File.exists?(@ec2_key)
      warning_ec2_key
    end

    send_and_execute(file)
  end

private

  def warning_ec2_key
    puts "Please, verify EC2 credentials are stored as #{@ec2_key} file."
    puts "Exiting."
    exit 1
  end

  def send_and_execute(command_file)
    File.open(command_file) do |file|
      commands = file.read
      puts "Executing on #{@user}@#{@host} file #{command_file} (#{commands.split.size} lines)"

      ssh = Net::SSH.start(@host, @user, {:keys => [ @ec2_key ]})
      ssh.open_channel do |channel|
        STDOUT.sync = true
        channel.exec("bash -s") do |ch, success|
          channel.on_data do |ch, data|
            print data
          end
    
          channel.send_data commands
          channel.eof!
        end
      end
      ssh.loop
    end
  end
end