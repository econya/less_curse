module LessCurse
  module Widgets
    class TextView < Base
      def refresh
        window = LessCurse.screen.windows[self]
        LessCurse::Renderer::box_with_title window, @title
        FFI::NCurses.wmove window, 1, 1
        @data.to_s.split("\n").each_with_index do |line, idx|
          FFI::NCurses.mvwaddstr window, idx + 1, 1, line
        end
      end
    end
  end
end
