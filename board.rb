require_relative "tile"

class Board
    def initialize(height, width, mines)
        @height = height
        @width = width
        @mines = mines
    end

    def populate
        Array.new(@height) {Array.new(@width) {
            Tile.new
            }}
    end
end