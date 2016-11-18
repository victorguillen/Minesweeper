require_relative "board"

class MineSweeper

  attr_accessor :board

  def initialize(filename)
    @board = Board.from_file(filename)
    @pos = []
  end

  def run
    until game_over?
      play_turn
    end
    puts bomb? ? "You lost :(" : "Your the man"
  end

  def game_over?
    bomb? || won?
  end

  def bomb?
    safe_spaces = @board.grid.flatten.select { |tile| tile.value == 9 }
    safe_spaces.any? { |tile| tile.given }
  end

  def won?
    safe_spaces = @board.grid.flatten.select { |tile| tile.value != 9 }
    safe_spaces.all? { |tile| tile.given }
  end

  def play_turn
    @board.render
    @pos,flag  = prompt_user
    flag ? @board[@pos].flag : @board[@pos].flip
  end

  def flag
    puts "Would you like to place a flag this turn? ('y' or 'n')"
    gets.chomp == 'y' ? true : false
  end

  def prompt_user
    flag_choice = flag
    pos = nil
    until pos && valid_position(pos)
      puts "Input a coordinate. (ex. '1,4')"
      pos = gets.chomp.split(",").map{|cord| cord.to_i}.reverse
    end
    [pos,flag_choice]
  end

  def valid_position(pos)
    condition = pos.size == 2 &&
      pos.all?{|cord| (0..7).include?(cord)} && @board[pos].given?
    puts "you messed up" unless condition
    condition
  end
end

game = MineSweeper.new('minefield1.txt')
game.run
