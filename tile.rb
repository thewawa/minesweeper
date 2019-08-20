require_relative "board"

class Tile
    attr_reader :position
    attr_accessor :content, :mined, :revealed, :flagged, :neighbors, :neighbor_bombs

    def initialize(position)
        @position = position
        @content = " "
        @mined = false
        @revealed = false
        @flagged = false
    end

    def inspect
        { 'position' => @position, 
        'mined' => @mined, 
        'content' => @content }.inspect
    end

    def list_neighbors(board)
        @neighbors = []
        row = @position[0]
        column = @position[1]

        #row above
        if row > 0
            if column > 0
                @neighbors << board.tiles[row-1][column-1]
            end

            @neighbors << board.tiles[row-1][column]

            if column < board.width - 1
                @neighbors << board.tiles[row-1][column+1]
            end
        end

        #same row
        if column > 0
            @neighbors << board.tiles[row][column-1]
        end

        if column < board.width - 1
            @neighbors << board.tiles[row][column+1]
        end

        #row below
        if row < board.width - 1
            if column > 0
                @neighbors << board.tiles[row+1][column-1]
            end

            @neighbors << board.tiles[row+1][column]

            if column < board.width - 1
                @neighbors << board.tiles[row+1][column+1]
            end
        end

        @neighbors
    end

    def neighbor_bomb_count(array)
        @neighbor_bombs = 0
        @neighbor_bombs += array.count { |tile| tile.mined == true}

        @neighbor_bombs
    end

    def reveal(board)
        list_neighbors(board)
        neighbor_bomb_count(@neighbors)

        return if @mined == true
        return if @revealed == true

        if @neighbor_bombs > 0
            @content = "#{@neighbor_bombs}"
        else
            @content = "_"
        end

        @revealed = true
    end
end