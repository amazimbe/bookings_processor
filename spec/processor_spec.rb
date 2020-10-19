# frozen_string_literal: true

RSpec.describe BookingsProcessor::Processor do
  subject(:processor) { described_class.new }

  describe '#process' do
    before { processor.process('spec/fixtures/booking_requests') }
    it 'stores rejects' do
      expect(processor.rejects.length).to be 3
    end
  end
end
