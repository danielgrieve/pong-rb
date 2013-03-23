module Pong
  class Player < Paddle
    def initialize(game)
      super(game.window)
      @x = game.window.width - @width - 30
    end
  end
end
