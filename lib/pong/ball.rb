module Pong
  class Ball
    attr_reader :x, :y, :width, :height, :speed_x, :speed_y

    def initialize(window)
      @window = window

      @height = 10
      @width = 10

      @color = Gosu::Color.new(255, 255, 255, 255)

      reset
    end

    def reset
      @x = @window.width / 2
      @y = @window.height / 2

      @speed_x = (Random.rand(4.0..6.0)).round(2)
      @speed_y = (Random.rand(2.0..4.0)).round(2)

      @speed_x = -@speed_x if (rand * 1).round == 1
      @speed_y = -@speed_y if (rand * 1).round == 1
    end

    def move
      @window.player_scored if player_scored?
      @window.opponent_scored if opponent_scored?

      if collides_with?(player)
        @speed_x = -@speed_x
        @window.play_collision
      elsif collides_with?(opponent)
        @speed_x = -@speed_x
        @window.play_collision
        @window.opponent.reset_reaction_amount
      end

      if collides_with_walls?
        @speed_y = -@speed_y
        @window.play_collision
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

    def player
      @player ||= @window.player
    end

    def opponent
      @opponent ||= @window.opponent
    end

    def player_scored?
      @x <= 0
    end

    def opponent_scored?
      @x + @width >= @window.width
    end
  end
end
