require_relative 'lib/config/app'
require_relative 'lib/constants/constants'

def main
  fileinput = ARGV[0]
  file = File.open(fileinput)
  command_session = App.new.command_session
  file.readlines.each do |line|
    inputs = line.split(' ')
    command_session.execute_command(inputs[Constants::ZERO], inputs)
  end
end

main
