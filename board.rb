require_relative "tile"

class Board
    attr_reader :height, :width
    attr_accessor :mines

    def initialize(height, width, mines)
        @height = height
        @width = width
        @mines = mines
    end

    def populate
        board = Array.new(@height) {Array.new(@width) {0}}
        
        board.each.with_index do |row, idx1|
            row.each.with_index do |tile, idx2|
                row[idx2] = Tile.new([idx1,idx2], false)
            end
        end

        board
    end

    def plant_mines

    end
end