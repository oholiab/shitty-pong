$:.push File.expand_path('../lib', __FILE__)
$:.push File.expand_path('../lib/lib', __FILE__)

require 'java'
require 'lwjgl.jar'
require 'slick.jar'

java_import org.newdawn.slick.BasicGame
java_import org.newdawn.slick.GameContainer
java_import org.newdawn.slick.Graphics
java_import org.newdawn.slick.Image
java_import org.newdawn.slick.Input
java_import org.newdawn.slick.SlickException
java_import org.newdawn.slick.AppGameContainer

MEDIADIR = "media"
module Java
  module OrgNewdawnSlick
    class Image
      attr_accessor :x, :y
      attr_accessor :angle
    end
  end
end

def media(resource)
  unless resource.match(/\./)
    resource = resource + ".png"
  end
  MEDIADIR + "/" + resource
end

class PongGame < BasicGame

  def init(container)
    @bg = Image.new(media 'bg')
    @ball = Image.new(media 'ball')
    @paddle = Image.new(media 'paddle')
    @paddle.x = 200
    @ball.x = @ball.y = 200
    @ball.angle = 45
  end

  def render(container, graphics)
    @bg.draw(0, 0)
    @ball.draw(@ball.x, @ball.y)
    @paddle.draw(@paddle.x, 400)
    graphics.draw_string('JRuby Shitty Pong (ESC to exit)', 8, container.height - 30)
  end

  def update(container, delta)
    input = container.get_input
    container.exit if input.is_key_down(Input::KEY_ESCAPE)

    if input.is_key_down(Input::KEY_LEFT) and @paddle.x > 0
      @paddle.x -= 0.3 * delta
    end

    if input.is_key_down(Input::KEY_RIGHT) and @paddle.x < container.width - @paddle.width
      @paddle.x += 0.3 * delta
    end
    @ball.x += 0.3 * delta * Math.cos(@ball.angle * Math::PI / 180)
    @ball.y += 0.3 * delta * Math.sin(@ball.angle * Math::PI / 180)

    if (@ball.x > container.width - @ball.width) || (@ball.y < 0) || (@ball.x <= 0) 
      @ball.angle = (@ball.angle + 90) % 360
    end

    if @ball.y > container.height
      @paddle.x = 200
      @ball.x = 200
      @ball.y = 200
      @ball.angle = 45
    end

    if @ball.x >= @paddle.x && @ball.x <= (@paddle.x + @paddle.width) && @ball.y.round >= (400 - @ball.height)
      @ball.angle = (@ball.angle + 90) % 360
    end
  end
end

app = AppGameContainer.new(PongGame.new('Shitty Pong'))
app.set_display_mode(640, 480, false)
app.start
