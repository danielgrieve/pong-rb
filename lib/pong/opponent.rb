module Pong
  class Opponent < Paddle
    def initialize(window)
      super(window)
      @x = 30
      @ball = window.ball
    end

    def move
      @y = ball_center - @height / 2
    end

    private
    def ball_center
      @ball.y + (@ball.height / 2)
    end
  end
end
