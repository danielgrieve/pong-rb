module Pong
  class Window < Gosu::Window
    attr_reader :player, :opponent

    def initialize
     super(640, 480, false)
     self.caption = 'Pong'

     @player = Player.new(self)
     @opponent = Opponent.new(self)
     @ball = Ball.new(self)
    end

    def update
      if button_down?(Gosu::KbDown)
        @player.move_down
      end

      if button_down?(Gosu::KbUp)
        @player.move_up
      end

      @ball.move
      @opponent.move
    end

    def draw
      @player.draw
      @opponent.draw
      @ball.draw
    end
  end
end
