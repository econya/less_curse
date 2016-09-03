require "less_curse/version"
require "less_curse/screen"
require "less_curse/actions"

# Widgets
require "less_curse/list"

module LessCurse
  def self.screen
    @@screen ||= Screen.new
  end

  def self.show_screen
    @@screen.show
  end
end
