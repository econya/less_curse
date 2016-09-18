require 'logger'
require 'ffi-ncurses'

require 'less_curse/version'
require 'less_curse/geometry'
require 'less_curse/screen'
require 'less_curse/actions'
require 'less_curse/null_logger'

require "less_curse/renderer"

require "less_curse/widgets"

module LessCurse
  @@actions = {
    FFI::NCurses::KEY_TAB => lambda { screen.focus_next }
    }

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
      rectangle.position.y, rectangle.position.x
  end

  def self.enter_loop!
    loop do
      break if !handle_input
      screen.repaint
    end
  end

  # Read from keyboard, handle keypress oneself or dispatch
  # to focused widget.
  def self.handle_input
    key = FFI::NCurses.wgetch FFI::NCurses::stdscr
    debug_msg "key press: #{key} / keyname: #{FFI::NCurses::keyname key} / #{FFI::NCurses::KEY_CTRL_Q}"

    # That will let us break out of the loop
    return false if key == FFI::NCurses::KEY_CTRL_Q

    if @@actions[key]
      # Global actions first
      @@actions[key].call
    else
      screen.focused_widget.handle_input key
    end
  end

  def self.debug_msg msg
    logger.debug msg
  end

  def self.logger
    @@logger ||= LessCurse::NullLogger.new
  end

  def self.log_to! file
    @@logger = Logger.new(file)
  end
end
