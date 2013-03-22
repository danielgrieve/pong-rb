module Pong
  class Paddle
    attr_reader :x, :y, :width, :height

    def initialize(window)
      @window = window

      @height = 100
      @width = 10
      @y = 20

      @color = Gosu::Color.new(255, 255, 255, 255)
    end

    def move_down
      move_amount = 4

      if bottom_point(@y + move_amount) >= max_height
        move_amount = max_height - (@y + @height)
      end

      @y += move_amount
    end

    def move_up
      move_amount = 4

      if (@y - move_amount) <= min_height
        move_amount = @y - min_height
      end

      @y -= move_amount
    end

    def draw
      @window.draw_quad(
        @x, @y, @color,
        @x + @width, @y, @color,
        @x, @y + @height, @color,
        @x + @width, @y + @height, @color
      )
    end

    private
    def bottom_point(y=@y)
      y + @height
    end

    def max_height
      @window.height - 10
    end

    def min_height
      10
    end
  end
end
