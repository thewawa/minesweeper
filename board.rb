require_relative "tile"

class Board
    attr_reader :height, :width
    attr_accessor :mines, :tiles

    def initialize(height, width, mines)
        @height = height
        @width = width
        @mines = mines
        @tiles = tiles
    end

    def populate
        @tiles = Array.new(@height) {Array.new(@width) {0}}
        
        @tiles.each.with_index do |row, idx1|
            row.each.with_index do |tile, idx2|
                row[idx2] = Tile.new([idx1,idx2])
            end
        end

        @tiles
    end

    def plant_mines
        while @tiles.flatten.count { |tile| tile.mined == true } < @mines
            coordinate = rand(0...81)
            random_tile = @tiles.flatten[coordinate]

            random_tile.mined = true
        end
    end

    def [](row, column)
        @tiles[row][column]
    end

    def reveal(tile)
        tile.reveal(@tiles)

        tile.neighbors.each do |neighbor|
            neighbor.list_neighbors(@tiles)

            if neighbor.mined == false && neighbor.revealed == false && neighbor.neighbors.any? { |ele| ele.content == "_" }
                reveal(neighbor)
            end
        end        

        if tile.mined == true
            mine_hit(tile) 

            return false
        end

        true
    end

    def render
        print " "
        (0...@width).each {|column| print " #{column}"}
        puts

        @tiles.each.with_index do |row, idx1|
            print "#{idx1}"
            row.each.with_index do |tile, idx2|
                print " #{tile.content}"
            end

            puts
        end
    end

    def mine_hit(tile)
        @tiles.flatten.each do |ele|
            ele.content = "*" if ele.mined == true
        end
        # game_over
    end

    # def game_over
    #     puts "You lost!"
    # end
end