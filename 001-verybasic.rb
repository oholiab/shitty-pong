$:.push File.expand_path('../lib', __FILE__)
$:.push File.expand_path('../lib/lib', __FILE__)

require 'java'
require 'lwjgl.jar'
require 'slick.jar'

java_import org.newdawn.slick.BasicGame
java_import org.newdawn.slick.GameContainer
java_import org.newdawn.slick.Graphics
java_import org.newdawn.slick.Input
java_import org.newdawn.slick.SlickException
java_import org.newdawn.slick.AppGameContainer

class Demo < BasicGame
  def render(container, graphics)
    graphics.draw_string('JRuby Demo (ESC to exit)', 8, container.height - 30)
  end

  def init(container)
  end

  def update(container, delta)
    input = container.get_input
    container.exit if input.is_key_down(Input::KEY_ESCAPE)
  end
end

app = AppGameContainer.new(Demo.new('SlickDemo'))
app.set_display_mode(640, 480, false)
app.start

