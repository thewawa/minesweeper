require_relative "board"

class Tile
    attr_reader :position
    attr_accessor :mined, :content, :neighbors, :neighbor_bombs, :revealed

    def initialize(position)
        @position = position
        @content = " "
        @mined = false
        @revealed = false
    end

    def inspect
        { 'position' => @position, 
        'mined' => @mined, 
        'content' => @content }.inspect
    end

    def list_neighbors(board_tiles)
        @neighbors = []
        row = @position[0]
        column = @position[1]

        #row above
        if row > 0
            if column > 0
                @neighbors << board_tiles[row-1][column-1]
            end

            @neighbors << board_tiles[row-1][column]

            if column < 8
                @neighbors << board_tiles[row-1][column+1]
            end
        end

        #same row
        if column > 0
            @neighbors << board_tiles[row][column-1]
        end

        if column < 8
            @neighbors << board_tiles[row][column+1]
        end

        #row below
        if row < 8
            if column > 0
                @neighbors << board_tiles[row+1][column-1]
            end

            @neighbors << board_tiles[row+1][column]

            if column < 8
                @neighbors << board_tiles[row+1][column+1]
            end
        end

        @neighbors
    end

    def neighbor_bomb_count(array)
        @neighbor_bombs = 0
        @neighbor_bombs += array.count { |tile| tile.mined == true}

        @neighbor_bombs
    end

    def reveal(board_tiles)
        self.list_neighbors(board_tiles)
        self.neighbor_bomb_count(@neighbors)

        return if @mined == true
        return if @revealed == true

        if @neighbor_bombs > 0
            @content = @neighbor_bombs
        else
            @content = "_"
        end

        @revealed = true
    end
    
    def flagged?

    end
end