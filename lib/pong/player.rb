module Pong
  class Player
    def initialize(window)
      @window = window

      @height = 100
      @width = 10
      @x = window.width - @width - 30
      @y = 10

      @color = Gosu::Color.new(255, 255, 255, 255)
    end

    def move_down
      if (@y + @height) < @window.height - 10
        @y += 4
      end
    end

    def move_up
      if @y > 10
        @y -= 4
      end
    end

    def draw
      @window.draw_quad(
        @x, @y, @color,
        @x + @width, @y, @color,
        @x, @y + @height, @color,
        @x + @width, @y + @height, @color
      )
    end
  end
end
