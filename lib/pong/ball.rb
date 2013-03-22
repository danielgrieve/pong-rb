module Pong
  class Ball
    def initialize(window, player)
      @window, @player = window, player

      @height = 10
      @width = 10
      @x = window.width / 2
      @y = 30

      @angle = 45
      @speed_x = 2 # randomise
      @speed_y = 2 # randomise

      @color = Gosu::Color.new(255, 255, 255, 255)
    end

    def move
      if collides_with?(@player)
        @speed_x = -@speed_x
      end

      if collides_with_walls?
        @speed_y = -@speed_y
      end

      @x += @speed_x
      @y += @speed_y
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
    def collides_with?(item)
      new_x = @x + @speed_x
      new_y = @y + @speed_y

      new_x >= item.x && (new_y >= item.y && new_y <= (item.y + item.height))
    end

    def collides_with_walls?
      new_y = @y + @speed_y

      new_y >= @window.height || new_y <= 0
    end

    def deg_to_rad(degrees)
      degrees * Math::PI / 180
    end
  end
end
