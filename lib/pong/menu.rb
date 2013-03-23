module Pong
  class Menu
    def initialize(window)
      @window = window

      @title_font = Gosu::Font.new(@window, 'Helvetica', 60)
      @help_font = Gosu::Font.new(@window, 'Helvetica', 24)
    end

    def draw
      @title_font.draw(@window.caption,
                       (@window.width / 2) - (@title_font.text_width(@window.caption) / 2),
                       60,
                       0xffffffff)

      help_text('Up / Down arrow keys to move', 150)
      help_text('P to pause the game', 190)
      help_text('M to mute game sounds', 230)
      help_text('Esc to quit back to this menu', 270)
      help_text('Press Return to start', 380, 0xffffff00)
      help_text('Press Esc to quit', 420, 0xffff0000)
    end

    private
    def help_text(msg, y, color=0xffffffff)
      @help_font.draw(msg,
                      (@window.width / 2) - (@help_font.text_width(msg) / 2),
                      y,
                      1, 1, 1, color)
    end
  end
end
