# frozen_string_literal: true
require 'byebug'

RSpec.describe BookingsProcessor::Booking do
  let(:theatre) { BookingsProcessor::Theatre.new(3, 3) }
  let(:start_row) { 1 }
  let(:end_row) { 1 }
  let(:start_col) { 0 }
  let(:end_col) { 1 }

  subject(:booking) do
    described_class.new(
      theatre, id: 1, start_row: start_row, start_col: 0, end_row: end_row, end_col: end_col
    )
  end

  describe '#valid?' do
    context 'booking spans multiple rows' do
      let(:end_row) { 2 }
      it 'returns false' do
        expect(booking.valid?).to be false
      end
    end

    context 'booking contains more than 5 seats' do
      let(:end_col) { 7 }
      it 'returns false' do
        expect(booking.valid?).to be false
      end
    end

    context 'when not enough seats are available' do
      before { theatre.seats[start_row] = Array.new([true, false, false]) }

      it 'returns false' do
        expect(booking.valid?).to be false
      end
    end

    context 'when booking leaves a single seat available' do
      it 'returns false' do
        expect(booking.valid?).to be false
      end
    end
  end
end
