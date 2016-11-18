require 'byebug'
require_relative 'tile'
class Board
  attr_reader :grid

  def self.empty_grid
    Array.new(8) do
      Array.new(8) { Tile.new(0) }
    end
  end

  def self.from_file(filename)
    rows = File.readlines(filename).map(&:chomp)
    tiles = rows.map do |row|
      nums = row.split("").map { |char| Integer(char) }
      nums.map { |num| Tile.new(num) }
    end

    self.new(tiles)
  end

  def initialize(grid = self.empty_grid)
    @grid = grid
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    tile = grid[x][y]
    tile.value = value
  end



  def render
    puts "  #{(0..7).to_a.join(" ")}"
    8.times do |x|
      row_output = "#{x} "
      8.times do |y|
        row_output += @grid[x][y].icon + " "
      end
      puts row_output
    end

  end

end
