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
        puts "Reveal tile (e.g. '3,5' where 3 is the row and 5 is the column):"

        gets.chomp.split(",")
    end

    def apply_guess(board)
        position = get_guess.map { |num| num.to_i }
        row = position[0]
        col = position[1]   

        tile = board[row, col]

        board.reveal(tile)
    end

    def play_round(board)
        status = apply_guess(board)

        if bomb?(status) == true
            puts "You lost!"
            exit 
        end

        board.render
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

    # def game_over?(board)
    #     return true if bomb? || won?(board)

    #     false
    # end

    def play(board)
        setup(board)
        board.render

        play_round(board) until won?(board)
    end
end

new_game = Game.new
new_game.play(new_game.board)