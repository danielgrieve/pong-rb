module Pong
  class Game
    attr_reader :player, :opponent, :ball, :window, :paused

    def initialize(window)
      @window = window
      @paused = false

      @ball = Ball.new(self)
      @player = Player.new(self)
      @opponent = Opponent.new(self)

      @wall_color = Gosu::Color.new(155, 255, 255, 255)
      @half_way_color = Gosu::Color.new(50, 255, 255, 255)
      @paused_background = Gosu::Color.new(150, 0, 0, 0)
      @score_font = Gosu::Font.new(@window, 'Helvetica', 60)
      @paused_font = Gosu::Font.new(@window, 'Helvetica', 20)

      @player_score = 0
      @opponent_score = 0

      @background_music = Gosu::Song.new(@window, 'media/background.mp3')
      @background_music.volume = 0.1
      @background_music.play(true)
      @collision_sound = Gosu::Sample.new('media/click.mp3')
    end

    def update
      unless @paused
        if @window.button_down?(Gosu::KbDown)
          @player.move_down
        end

        if @window.button_down?(Gosu::KbUp)
          @player.move_up
        end

        @ball.move
        @opponent.move
      end
    end

    def draw
      draw_paused if @paused

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

    def play_collision
      @collision_sound.play(0.5, 1, false)
    end

    def toggle_pause
      if @paused
        @background_music.play unless @background_music.playing?
        @paused = false
      else
        @background_music.pause if @background_music.playing?
        @paused = true
      end
    end

    private
    def draw_paused
      @window.draw_quad(
        0, 0, @paused_background,
        @window.width, 0, @paused_background,
        0, @window.height, @paused_background,
        @window.width, @window.height, @paused_background,
        3
      )

      text = 'Paused'
      text_width = @paused_font.text_width(text)
      @paused_font.draw(text, (@window.width / 2) - (text_width / 2), (@window.height / 2) - @paused_font.height, 4, 1, 1, 0xffffffff)
    end

    def draw_walls
      @window.draw_quad(
        0, 0, @wall_color,
        @window.width, 0, @wall_color,
        0, 10, @wall_color,
        @window.width, 10, @wall_color
      )

      @window.draw_quad(
        0, @window.height-10, @wall_color,
        @window.width, @window.height-10, @wall_color,
        0, @window.height, @wall_color,
        @window.width, @window.height, @wall_color
      )

      @window.draw_quad(
        @window.width / 2 - 5, 10, @half_way_color,
        @window.width / 2 + 5, 10, @half_way_color,
        @window.width / 2 - 5, @window.height - 10, @half_way_color,
        @window.width / 2 + 5, @window.height - 10, @half_way_color
      )
    end

    def draw_scores
      opponent_score_width = @score_font.text_width(@opponent_score)
      @score_font.draw(@player_score, (@window.width / 2) + 50, 30, 2, 1, 1, 0xff00ff00)
      @score_font.draw(@opponent_score, (@window.width / 2) - 50 - opponent_score_width, 30, 2, 1, 1, 0xff00ff00)
    end
  end
end
