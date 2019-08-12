require_relative "tile"
require_relative "board"

def create_board
    Board.new(9,9,10).populate
end

# create_board
# Array.new(9) {Array.new(9) {0}}
# tile = Tile.new([0,1], false)

board = Board.new(9,9,10)
board.populate
board.plant_mines
tile = board.tiles.flatten[29]
tile.list_neighbors(board.tiles)
tile.neighbor_bomb_count(tile.neighbors)