# frozen_string_literal: true

require 'dotenv/load'

module BookingsProcessor
  class Processor
    # moving these to .env did not work
    THEATRE_ROWS = 100
    THEATRE_COLS = 50

    attr_reader :rejects, :theatre

    def initialize
      @rejects = []
      @theatre = Theatre.new(ENV['THEATRE_ROWS'].to_i, ENV['THEATRE_COLS'].to_i)
    end

    def self.process(filename)
      Processor.new.process(filename)
    end

    def process(filename)
      filename = File.absolute_path(filename)

      File.foreach(filename) do |line|
        booking = Booking.new(theatre, parse(line))
        
        if booking.valid?
          theatre.update_seats(booking.start_row, booking.start_col, booking.end_col)
        else
          rejects << booking.id
        end
      end

      puts "#{rejects.length} bookings have been rejected"
      theatre.seats.each {|s| puts s.join('-')}
    end

    private

    def parse(line)
      line = line.gsub('(', '')
      line = line.gsub(')', '')
      tokens = line.split(',')

      start_row, start_col = tokens[1].split(':')
      end_row, end_col = tokens[2].split(':')

      {
        id: tokens[0],
        end_row: end_row.to_i,
        end_col: end_col.to_i,
        start_row: start_row.to_i,
        start_col: start_col.to_i
      }
    end
  end
end