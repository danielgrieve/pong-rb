module Pong
  class Opponent < Paddle
    attr_accessor :reaction_amount

    def initialize(game)
      super(game.window)
      @x = 30
      @ball = game.ball
      reset_reaction_amount
    end

    def move
      if @ball.speed_x < 0 && @ball.x < (@window.height / 2 - reaction_amount)
        # @y = ball_center - @height / 2
        if @ball.speed_y < 0
          if paddle_center < ball_center
            move_down
          else
            move_up
          end
        else
          if paddle_center > ball_center
            move_up
          else
            move_down
          end
        end
      end
    end

    def reset_reaction_amount
      @reaction_amount = Random.rand(0..150).round
    end

    private
    def ball_center
      @ball.y + (@ball.height / 2)
    end

    def paddle_center
      @y + (height / 2)
    end
  end
end
