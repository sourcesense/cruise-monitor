require 'rubygems'
require 'net/ssh'

module CruiseMonitor
  class DeployInstance

    def initialize(options)
      @host = options[:host]
      @user = options[:user]
      @credentials = options[:credentials]
    end

    def execute_remotely(file)
      if credentials_not_set
        warning_credentials
        exit 1
      end

      send_and_execute(file)
    end

  private

    def credentials_not_set
      ! File.exists?(@credentials)
    end

    def warning_credentials
      puts "Please, verify credentials are stored as #{@credentials} file."
      puts "Exiting."
    end

    def send_and_execute(command_file)
      File.open(command_file) do |file|
        commands = file.read
        puts "Executing on #{@user}@#{@host} file '#{command_file}' (#{commands.split.size} lines)"

        ssh = Net::SSH.start(@host, @user, {:keys => [ @credentials ]})
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
end