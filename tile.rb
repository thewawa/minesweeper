require_relative "board"

class Tile
    attr_reader :position
    attr_accessor :mined, :content

    def initialize(position, mined)
        @position = position
        @mined = mined
        @content = "_"
    end

    def inspect
        { 'position' => @position, 'mined' => @mined, 'content' => @content }.inspect
    end

    def neighbors
        
    end

    def neighbor_bomb_count
        
    end

    def reveal
        
    end

    def bombed?

    end

    def flagged?

    end

    def revealed?

    end
end