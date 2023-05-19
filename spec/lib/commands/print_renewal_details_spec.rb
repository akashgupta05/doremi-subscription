require 'spec_helper'
require_relative '../../../lib/commands/print_renewal_details'
require_relative '../../../lib/models/error/code'

RSpec.describe Commands::PrintRenewalDetails do
  let(:renewal_service) { double('RenewalService') }
  subject(:command) { described_class.new(renewal_service) }

  describe '#execute' do
    context 'with an error' do
      before do
        allow(renewal_service).to receive(:calculate_renewal_dates).and_raise(ErrorCode::SUBSCRIPTIONS_NOT_FOUND)
      end

      it 'prints error code' do
        expect(renewal_service).to receive(:calculate_renewal_dates).and_raise(ErrorCode::SUBSCRIPTIONS_NOT_FOUND)
        expect($stdout).to receive(:puts).with(ErrorCode::SUBSCRIPTIONS_NOT_FOUND)
        command.execute(nil)
      end
    end

    context 'with valid arguments' do
      let(:renewal_reminders) { ['RENEWAL_REMINDER MUSIC 10-03-2022'] }
      let(:renewal_amount) { 100 }

      before do
        allow(renewal_service).to receive(:calculate_renewal_dates).and_return(renewal_reminders)
        allow(renewal_service).to receive(:calculate_renewal_amount).and_return(renewal_amount)
      end

      it 'prints the renewal reminder list and renewal amount' do
        expect(renewal_service).to receive(:calculate_renewal_dates).once
        expect(renewal_service).to receive(:calculate_renewal_amount).once
        expect($stdout).to receive(:puts).with(renewal_reminders.first)
        expect($stdout).to receive(:puts).with(renewal_amount)

        command.execute(nil)
      end
    end
  end
end
