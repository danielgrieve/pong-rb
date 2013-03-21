module Pong
  class Ball
    def initialize(window, player)
      @window, @player = window, player

      @height = 10
      @width = 10
      @x = window.width / 2
      @y = 30

      @angle = 0.2 # TODO randomise
      @speed = 4 # TODO randomise
      calculate_direction

      @color = Gosu::Color.new(255, 255, 255, 255)
    end

    def move
      if collides_with?(@player)
        calculate_direction
      end

      @x += @direction_x
      @y += @direction_y
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
    def calculate_direction
      @direction_x = @speed * Math.cos(@angle)
      @direction_y = @speed * Math.sin(@angle)
    end

    def collides_with?(item)
      new_x = @x + @direction_x
      new_y = @y + @direction_y

      new_x >= item.x && (new_y >= item.y && new_y <= (item.y + item.height))
    end
  end
end
