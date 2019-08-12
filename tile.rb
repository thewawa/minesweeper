require_relative "board"

class Tile
    attr_reader :position
    attr_accessor :mined, :content, :neighbors, :neighbor_bomb_count, :revealed

    def initialize(position)
        @position = position
        @content = "_"
        @mined = false
        @revealed = false
    end

    def inspect
        { 'position' => @position, 
        'mined' => @mined, }.inspect
    end

    def list_neighbors(board)
        @neighbors = []
        row = @position[0]
        column = @position[1]

        #row above
        if row > 0
            if column > 0
                @neighbors << board[row-1][column-1]
            end

            @neighbors << board[row-1][column]

            if column < 8
                @neighbors << board[row-1][column+1]
            end
        end

        #same row
        if column > 0
            @neighbors << board[row][column-1]
        end

        if column < 8
            @neighbors << board[row][column+1]
        end

        #row below
        if row < 8
            if column > 0
                @neighbors << board[row+1][column-1]
            end

            @neighbors << board[row+1][column]

            if column < 8
                @neighbors << board[row+1][column+1]
            end
        end

        @neighbors
    end

    def neighbor_bomb_count(array)
        @neighbor_bomb_count = 0
        @neighbor_bomb_count += array.count { |tile| tile.mined == true}

        @neighbor_bomb_count
    end

    def reveal
        # if @neighbor_bomb_count == 0
    end

    def revealed?
        
    end
    
    def flagged?

    end
end