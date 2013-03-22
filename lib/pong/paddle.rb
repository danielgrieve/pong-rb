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
      movement = 4

      if bottom_point(@y + movement) >= max_height
        movement = max_height - (@y + @height)
      end

      @y += movement
    end

    def move_up
      movement = 4

      if (@y - movement) <= min_height
        movement = @y - min_height
      end

      @y -= movement
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
