# frozen_string_literal: true

require 'byebug'
module BookingsProcessor
  class Theatre
    attr_reader :seats

    def initialize(rows, cols)
      @seats = Array.new(rows) { Array.new(cols, true) }
    end

    def seats_available?(row, start_col, end_col)
      seats[row][start_col..end_col].all?
    end

    def update_seats(row, start_col, end_col)
      (start_col..end_col).each do |col|
        seats[row][col] = false
      end
    end

    # duplicate the row, update seat availability and check if
    # that leaves a single seat available
    def leaves_single_available_seat?(row, start_col, end_col)
      duplicate_row = seats[row].clone
      (start_col..end_col).each do |col|
        duplicate_row[col] = false
      end
      single_available_seat?(duplicate_row)
    end

    private

    def single_available_seat?(row)
      return true if row == [true]
      return true if row == [true, false]
      return true if row == [false, true]

      row_length = row.length

      row.each_with_index do |available, index|
        next unless available

        return true if index.zero? && row[index + 1] == false && row[index + 2] == false
        return true if index == row_length - 1 && row[index - 1] == false && row[index - 2] == false
        return true if row[index - 1] == false && row[index + 1] == false
      end

      false
    end
  end
end
