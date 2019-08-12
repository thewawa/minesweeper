require_relative "tile"
require_relative "board"

def create_board
    Board.new(9,9,10).populate
end

# create_board
# Array.new(9) {Array.new(9) {0}}
# tile = Tile.new([0,1])

board = Board.new(9,9,10)
board.populate

board.plant_mines
# tiles = board.tiles

# tile = tiles.flatten[24]
# tile.reveal(tiles)

# tile.neighbors
# tile.neighbor_bombs

board.render