require_relative "tile"
require_relative "board"

def setup(board)    
    board.populate

    board.plant_mines    
end

def get_guess

end

def play_round(board)
    board.render

    # get_guess(board)

    board[0,0].reveal
end

def game_over?(board)
    # return false if get_guess == false

    true
end

def won?(board)
    # return false if (...)

    true
end

def play(board)
    play_round(board) until game_over?

    if won?
        puts "You won!" 
    else
        puts "You lost!"
    end
end

new_game = Board.new(9,9,10)
setup(new_game)
# tiles = new_game.tiles

# play_round(new_game)

# new_game.render
# new_game.reveal(new_game[0,0])