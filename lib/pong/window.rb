module Pong
  class Window < Gosu::Window
    attr_reader :player, :opponent, :ball

    def initialize
     super(640, 480, false)
     self.caption = 'Pong'

     @ball = Ball.new(self)
     @player = Player.new(self)
     @opponent = Opponent.new(self)

     @color = Gosu::Color.new(155, 255, 255, 255)
     @score_font = Gosu::Font.new(self, 'Helvetica', 60)

     @player_score = 0
     @opponent_score = 0
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
      draw_walls
      draw_scores
      @ball.draw
      @player.draw
      @opponent.draw
    end

    def player_scored
      @player_score += 1
      @ball.reset
    end

    def opponent_scored
      @opponent_score += 1
      @ball.reset
    end

    private
    def draw_walls
      draw_quad(
        0, 0, @color,
        width, 0, @color,
        0, 10, @color,
        width, 10, @color
      )

      draw_quad(
        0, height-10, @color,
        width, height-10, @color,
        0, height, @color,
        width, height, @color
      )
    end

    def draw_scores
      @score_font.draw(@player_score, (width / 2) + 50, 30, 1)
      @score_font.draw(@opponent_score, (width / 2) - 50, 30, 1)
    end
  end
end
