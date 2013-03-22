module Pong
  class Ball
    def initialize(window)
      @window = window

      @player = window.player
      @opponent = window.opponent

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
      if collides_with_player? || collides_with_opponent?
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
    def collides_with_player?
      new_x = @x + @speed_x
      new_y = @y + @speed_y

      new_x >= @player.x && (new_y >= @player.y && new_y <= (@player.y + @player.height))
    end

    def collides_with_opponent?
      new_x = @x + @speed_x
      new_y = @y + @speed_y

      new_x <= @opponent.x && (new_y >= @opponent.y && new_y <= (@opponent.y + @opponent.height))
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
