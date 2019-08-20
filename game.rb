require_relative "tile"
require_relative "board"
require 'yaml'

class Game
    attr_accessor :board

    def initialize(level)
        if level == "Easy"
            @board = Board.new(9,9,10)
        elsif level == "Medium"
            @board = Board.new(16,16,40)
        elsif level == "Hard"
            @board = Board.new(30,16,99)
        end
    end

    def setup   
        @board.populate

        @board.plant_mines

        @board.render    
    end

    def get_guess
        puts "Type one of the following:"
        puts "'r' to reveal a tile (e.g. 'r3,5')"
        puts "'f' to flag/unflag a tile (e.g. 'f8,0')"
        puts "'save' to save current game"
        puts "'load' to load previously saved game"

        gets.chomp
    end

    def which_tile?(input)
        max_height = @board.height - 1
        max_width = @board.width - 1
        max_input_length = 2 + max_height.to_s.length + max_width.to_s.length

        #filter out inputs that are typos (e.g. 'r,0') or unreal (e.g. 'f999,999')
        if input[1] == "," || input[-1] == "," || input.length < 4 || input.length > max_input_length
            return
        end
        
        coordinates = input[1..-1].split(",")
        
        position = coordinates.map { |num| num.to_i }
        row = position[0]
        col = position[1]

        tile = @board[row, col]
    end

    def process_command(input)
        if input[0] == "r"
            process_reveal(input)
        elsif input[0] == "f"
            process_flag(input)
        elsif input == "save"
            save_game
        elsif input == "load"
            load_game
        end
    end

    def process_reveal(input)
        tile = which_tile?(input)

        return if tile.content == "F"

        apply_reveal(tile)
    end

    def process_flag(input)
        tile = which_tile?(input)
        
        if tile.flagged == false
            @board.flag_tile(tile)
        else
            @board.unflag_tile(tile)
        end

        return true
    end

    def process_guess
        input = get_guess

        begin
            process_command(input)
        rescue => exception
            puts "Incorrect input or there was an error. Try again."
            sleep(2)

            @board.render
            process_guess
        end        
    end

    def apply_reveal(tile)
        @board.reveal(tile)
    end

    def play_round
        status = process_guess

        @board.render

        if bomb?(status) == true
            puts "You lost!"
            exit 
        end
    end

    def bomb?(status)
        return true if status == false

        false
    end

    def won?
        tiles = @board.tiles        

        if (tiles.flatten.length - tiles.flatten.count {|tile| !tile.mined && tile.revealed}) == @board.mines
            puts "You won!"
            return true 
        end

        false
    end

    def play
        play_round until won?
    end

    def save_game
        saved_game = self.to_yaml        
        File.open('saved_game', 'w+') { |file| file.write(saved_game) }

        puts "Game saved!"
        sleep(3)

        return true
    end

    def load_game
        begin
            file = File.open('saved_game', 'r')
        rescue => exception
            puts "There is no saved game!"
        end

        puts "Loading game..."
        sleep(3)
        
        saved_game = YAML::load(file)
        
        saved_game.board.render
        saved_game.play
    end
end

def ask_for_level
    puts "Choose level. Type 1 for Easy, 2 for Medium, 3 for Hard:"

    level = gets.chomp

    if level == "1"
        return Game.new("Easy")
    elsif level == "2"
        return Game.new("Medium")
    elsif level == "3"
        return Game.new("Hard")
    end
end

new_game = ask_for_level
new_game.setup
new_game.play