module Pong
  class Window < Gosu::Window
    def initialize
     super(640, 480, false)
     self.caption = 'Pong'

     @player = Player.new(self)
     @ball = Ball.new(self, @player)
    end

    def update
      if button_down?(Gosu::KbDown)
        @player.move_down
      end

      if button_down?(Gosu::KbUp)
        @player.move_up
      end

      @ball.move
    end

    def draw
      @player.draw
      @ball.draw
    end
  end
end
