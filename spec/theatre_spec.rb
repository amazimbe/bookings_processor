# frozen_string_literal: true

require 'byebug'

RSpec.describe BookingsProcessor::Theatre do
  subject(:theatre) { described_class.new(3, 3) }

  describe '#seats_available?' do
    it 'returns true if seats in the booking are available' do
      expect(theatre.seats_available?(1, 0, 1)).to be true
    end

    context 'when not enough seats are available' do
      before { theatre.seats[1] = Array.new([true, false, false]) }

      it 'returns false' do
        expect(theatre.seats_available?(1, 0, 1)).to be false
      end
    end
  end

  describe '#leaves_single_available_seat?' do
    context 'leaves only first seat available' do
      it 'returns false' do
        expect(theatre.leaves_single_available_seat?(0, 1, 2)).to be true
      end
    end

    context 'leaves only last seat available' do
      it 'returns false' do
        expect(theatre.leaves_single_available_seat?(0, 0, 1)).to be true
      end
    end

    context 'leaves middle single seat available' do
      before { theatre.seats[0] = Array.new([false, true, true, false]) }

      it 'returns true if row has a single available seat' do
        expect(theatre.leaves_single_available_seat?(0, 1, 1)).to be true
      end
    end
  end
end
