module Pong
  class Ball
    attr_reader :x, :y, :width, :height

    def initialize(window)
      @window = window

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
      if collides_with?(player) || collides_with?(opponent)
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
    def collides_with?(paddle)
      new_x = @x + @speed_x + (@width / 2)
      new_y = @y + @speed_y + (@height / 2)

      (new_x >= paddle.x && new_x <= (paddle.x + paddle.width)) && (new_y >= paddle.y && new_y <= (paddle.y + paddle.height))
    end

    def collides_with_walls?
      new_y = @y + @speed_y
      new_y >= @window.height - 20 || new_y <= 10
    end

    def deg_to_rad(degrees)
      degrees * Math::PI / 180
    end

    def player
      @player ||= @window.player
    end

    def opponent
      @opponent ||= @window.opponent
    end
  end
end
