require_relative "tile"
require_relative "board"

class Game
    attr_accessor :board

    def initialize
        @board = Board.new(9,9,10)
    end

    def setup(board)    
        board.populate

        board.plant_mines    
    end

    def get_guess
        puts "Start your guess with 'r' to reveal a tile (e.g. 'r3,5') or 'f' to flag/unflag it (e.g. 'f8,0'):"

        gets.chomp
    end

    def process_guess(board)
        input = get_guess
        coordinates = input[1..-1].split(",")
        
        position = coordinates.map { |num| num.to_i }
        row = position[0]
        col = position[1]
        tile = board[row, col]

        if input[0] == "r"
            return if tile.content == "F"
            apply_reveal(board, tile)
        elsif input[0] == "f" && tile.flagged == false
            board.flag_tile(tile)
            return true
        elsif input[0] == "f" && tile.flagged == true
            board.unflag_tile(tile)
            return true
        end
    end

    def apply_reveal(board, tile)
        board.reveal(tile)
    end

    def play_round(board)
        status = process_guess(board)

        board.render

        if bomb?(status) == true
            puts "You lost!"
            exit 
        end
    end

    def bomb?(status)
        return true if status == false

        false
    end

    def won?(board)
        tiles = board.tiles        

        if (tiles.flatten.length - tiles.flatten.count {|tile| !tile.mined && tile.revealed}) == board.mines
            puts "You won!"
            return true 
        end

        false
    end

    def play(board)
        setup(board)
        board.render

        play_round(board) until won?(board)
    end
end

new_game = Game.new
new_game.play(new_game.board)