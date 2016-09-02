require "less_curse/version"
require "less_curse/screen"

module LessCurse
  def self.screen
    @@screen ||= Screen.new
  end
end
