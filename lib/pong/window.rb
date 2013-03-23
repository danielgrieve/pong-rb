module Pong
  class Window < Gosu::Window
    def initialize
      super(640, 480, false)
      self.caption = 'Pong'

      start_menu
    end

    def update
      @game.update if @game
    end

    def draw
      @menu.draw if @menu
      @game.draw if @game
    end

    def start_menu
      @menu = Menu.new(self)
    end

    def start_game
      @game = Game.new(self)
      @menu = nil
    end

    def button_down(id)
      if id == Gosu::KbReturn && @menu
        puts 'start game'
        start_game
      end

      if id == Gosu::KbEscape
        if @game
          @game.quit
          @game = nil
          start_menu
        else
          close
        end
      end

      if @game
        @game.toggle_pause if id == Gosu::KbP
        @game.toggle_mute if id == Gosu::KbM && !@game.paused
      end
    end
  end
end
