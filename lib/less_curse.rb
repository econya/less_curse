require 'ffi-ncurses'

require 'less_curse/version'
require 'less_curse/geometry'
require 'less_curse/screen'
require 'less_curse/actions'

# Widgets
require "less_curse/list"

module LessCurse
  def self.screen
    @@screen ||= Screen.new
  end

  def self.show_screen
    @@screen.show
  end

  def self.close_screen
    FFI::NCurses.endwin
  end

  def self.window rectangle
    FFI::NCurses.newwin rectangle.size.height, rectangle.size.width,
      rectangle.position.x, rectangle.position.y
  end
end
