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

    def reveal(tile)
        # tile.reveal(@tiles)

        # tile.neighbors.each do |neighbor|
        #     reveal(neighbor) if neighbor.mined == false
        # end
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

    # def hit_mine?(tile)
    #     @tiles.each do |tile|
    #         tile.content = "*" if tile.mined == true
    #     end
    # end
end