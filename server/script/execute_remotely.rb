#!/usr/bin/env ruby

require 'rubygems'
require 'net/ssh'

BUILD_SERVER = 'www.cruise-monitor.tk'
EC2_KEY = "/Users/jacopo/.ec2/build.pem"

def execute_remotely(command_file)
  File.open(command_file) do |file|
    commands = file.read
    puts "Executing #{command_file} (#{commands.split.size} lines)"

    ssh = Net::SSH.start(BUILD_SERVER, 'ubuntu', {:keys => [ EC2_KEY ]})
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

if ARGV.empty?
  puts "Please give me a path!"
  exit 1
end

if ! File.exists?(EC2_KEY)
  puts "Please, verify EC2 credentials are stored as #{EC2_KEY} file."
  puts "Exiting."
  exit 1
end

execute_remotely ARGV[0]