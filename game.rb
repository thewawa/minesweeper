require_relative "tile"
require_relative "board"

def create_board
    board = Board.new(9,9,10)
end

# create_board
# tile = Tile.new([0,1], false)
# board = Board.new(9,9,10).populate