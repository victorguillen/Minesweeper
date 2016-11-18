require "colorize"
require "byebug"

class Tile

  attr_reader :value

  attr_accessor :flag, :given

  def initialize(value, flag = 0)
    @value = value
    @given = false
    @flag = false
  end

  def flag
    @flag = !@flag
  end

  def color
    @flag ? :red : :white
  end

  def given?
    !@given
  end

  def icon
    if given
      case value
        when 0 then " "
        when (1..8) then value.to_s.colorize(:blue)
        when 9 then "B".colorize(:red)
      end
    else "*".colorize(color)
    end
  end

  def flip
    @given = true
  end
end
