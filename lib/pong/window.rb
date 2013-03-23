module Pong
  class Window < Gosu::Window
    attr_reader :player, :opponent, :ball

    def initialize
     super(640, 480, false)
     self.caption = 'Pong'

     @paused = false

     @ball = Ball.new(self)
     @player = Player.new(self)
     @opponent = Opponent.new(self)

     @wall_color = Gosu::Color.new(155, 255, 255, 255)
     @half_way_color = Gosu::Color.new(50, 255, 255, 255)
     @paused_background = Gosu::Color.new(150, 0, 0, 0)
     @score_font = Gosu::Font.new(self, 'Helvetica', 60)
     @paused_font = Gosu::Font.new(self, 'Helvetica', 20)

     @player_score = 0
     @opponent_score = 0

     @background_music = Gosu::Song.new(self, 'media/background.mp3')
     @background_music.volume = 0.1
     @background_music.play(true)
     @collision_sound = Gosu::Sample.new('media/click.mp3')
    end

    def update
      unless @paused
        if button_down?(Gosu::KbDown)
          @player.move_down
        end

        if button_down?(Gosu::KbUp)
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

    def button_down(id)
      if id == Gosu::KbP
        if @paused
          @background_music.play unless @background_music.playing?
          @paused = false
        else
          @background_music.pause if @background_music.playing?
          @paused = true
        end
      end
    end

    private
    def draw_paused
      draw_quad(
        0, 0, @paused_background,
        width, 0, @paused_background,
        0, height, @paused_background,
        width, height, @paused_background,
        3
      )

      text = 'Paused'
      text_width = @paused_font.text_width(text)
      @paused_font.draw(text, (width / 2) - (text_width / 2), (height / 2) - @paused_font.height, 4, 1, 1, 0xffffffff)
    end

    def draw_walls
      draw_quad(
        0, 0, @wall_color,
        width, 0, @wall_color,
        0, 10, @wall_color,
        width, 10, @wall_color
      )

      draw_quad(
        0, height-10, @wall_color,
        width, height-10, @wall_color,
        0, height, @wall_color,
        width, height, @wall_color
      )

      draw_quad(
        width / 2 - 5, 10, @half_way_color,
        width / 2 + 5, 10, @half_way_color,
        width / 2 - 5, height - 10, @half_way_color,
        width / 2 + 5, height - 10, @half_way_color
      )
    end

    def draw_scores
      opponent_score_width = @score_font.text_width(@opponent_score)
      @score_font.draw(@player_score, (width / 2) + 50, 30, 2, 1, 1, 0xff00ff00)
      @score_font.draw(@opponent_score, (width / 2) - 50 - opponent_score_width, 30, 2, 1, 1, 0xff00ff00)
    end
  end
end
