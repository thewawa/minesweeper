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
        Array.new(@height) {Array.new(@width) {
            Tile.new([0,0], false)
            }}
    end

    def plant_mines

    end
end