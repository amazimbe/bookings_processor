# frozen_string_literal: true

RSpec.describe BookingsProcessor::Processor do
  subject(:processor) { described_class.new }

  describe '#process' do
    before { processor.process('spec/fixtures/sample_booking_requests') }
    it 'stores rejects' do
      expect(processor.rejects.length).to be 10
    end
  end
end
