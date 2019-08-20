require_relative "tile"
require 'colorize'
require 'colorized_string'

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
            num_of_tiles = @height * @width

            coordinate = rand(0...num_of_tiles)
            random_tile = @tiles.flatten[coordinate]

            random_tile.mined = true
        end
    end

    def [](row, column)
        @tiles[row][column]
    end

    def reveal(tile)
        tile.reveal(self)

        tile.neighbors.each do |neighbor|
            neighbor.list_neighbors(self)

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

    def flag_tile(tile)
        if tile.content == " "
            tile.content = "F"
            tile.flagged = true
        end
    end

    def unflag_tile(tile)
        if tile.content == "F"
            tile.content = " " 
            tile.flagged = false
        end
    end

    def mine_hit(tile)
        @tiles.flatten.each do |ele|
            ele.content = "*" if ele.mined == true
        end
    end

    def render
        system("cls")
        
        digits = @width.to_s.length
        
        #prints top row
        print " " * digits
        (0...@width).each {|column| print " #{column}"}
        puts

        #prints the first column of each row
        @tiles.each.with_index do |row, row_idx|
            if digits == 1
                print "#{row_idx}"
            elsif digits == 2
                if row_idx < 10
                    print " #{row_idx}" 
                else
                    print "#{row_idx}"
                end
            end

            #print each tile within a row
            row.each.with_index do |tile, col_idx|
                output = " #{apply_color(tile.content)}"

                if digits == 1
                    print output
                elsif digits == 2
                    if col_idx < 10
                        print output 
                    else
                        print " " + output
                    end
                end
            end

            puts
        end
    end

    def apply_color(symbol)
        if symbol.to_i == 1
            return symbol.colorize(:blue)
        elsif symbol.to_i == 2
            return symbol.colorize(:green)
        elsif symbol.to_i == 3
            return symbol.colorize(:red)
        elsif symbol.to_i == 4
            return symbol.colorize(:yellow)
        elsif symbol.to_i == 5
            return symbol.colorize(:magenta)
        elsif symbol.to_i > 5
            return symbol.colorize(:cyan)
        else
            return symbol.colorize(:default)
        end
    end
end