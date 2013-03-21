module Pong
  class Window < Gosu::Window
    def initialize
     super(640, 480, false)
     self.caption = 'Pong'

     @player = Player.new(self)
    end

    def update
      if button_down?(Gosu::KbDown)
        @player.move_down
      end

      if button_down?(Gosu::KbUp)
        @player.move_up
      end
    end

    def draw
      @player.draw
    end
  end
end
