# frozen_string_literal: true

module BookingsProcessor
  class Booking
    attr_reader :id, :start_row, :start_col, :end_row, :end_col, :theatre

    def initialize(theatre, attrs)
      @id = attrs[:id]
      @theatre = theatre
      @end_row = attrs[:end_row]
      @end_col = attrs[:end_col]
      @start_row = attrs[:start_row]
      @start_col = attrs[:start_col]
    end

    def valid?
      validate_same_row &&
      validate_seat_count && 
      theatre.seats_available?(start_row, start_col, end_col) &&
      !theatre.leaves_single_available_seat?(start_row, start_col, end_col)
    end

    private

    def validate_same_row
      start_row == end_row
    end

    def validate_seat_count
      end_col - start_col <= 5
    end
  end
end