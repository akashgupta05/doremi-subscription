require 'spec_helper'
require_relative '../../../lib/commands/session'

RSpec.describe Commands::Session do
  let(:session) { Commands::Session.new }

  describe '#register_command' do
    it 'registers a command' do
      command = double('command')
      session.register_command('command_name', command)
    end
  end

  describe '#execute_command' do
    let(:command) { double('command', execute: true) }

    before { session.register_command('command_name', command) }

    it 'executes a registered command' do
      inputs = %w[arg1 arg2]
      session.execute_command('command_name', inputs)
      expect(command).to have_received(:execute).with(inputs)
    end

    it 'raises an error for an invalid command' do
      expect { session.execute_command('invalid_command', []) }.to raise_error('Invalid Command')
    end
  end
end
