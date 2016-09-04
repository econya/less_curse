require 'ffi-ncurses'

require 'less_curse/version'
require 'less_curse/geometry'
require 'less_curse/screen'
require 'less_curse/actions'

require "less_curse/renderer"

require "less_curse/widgets"

module LessCurse
  def self.screen
    @@screen ||= Screen.new
  end

  def self.show_screen
    @@screen.show
  end

  def self.close_screen
    FFI::NCurses.endwin
    # flushinp, delwin?
  end

  def self.window rectangle
    FFI::NCurses.newwin rectangle.size.height, rectangle.size.width,
      rectangle.position.x, rectangle.position.y
  end

  def self.enter_loop!
    loop do
      key = FFI::NCurses.wgetch FFI::NCurses::stdscr
      # Check who can handle
      break if key == FFI::NCurses::KEY_UP
      break if key == FFI::NCurses::KEY_ENTER
      if key == FFI::NCurses::KEY_TAB
        # focus next
        #refresh
      end
    end
  end
end
