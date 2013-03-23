module Pong
  class Window < Gosu::Window
    def initialize
      super(640, 480, false)
      self.caption = 'Pong'

      @game = Game.new(self)
    end

    def update
      @game.update
    end

    def draw
      @game.draw
    end

    def button_down(id)
      @game.toggle_pause if id == Gosu::KbP
      @game.toggle_mute if id == Gosu::KbM && !@game.paused
    end
  end
end
