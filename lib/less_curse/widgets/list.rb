module LessCurse
  module Widgets
    class List < Base
      attr_accessor :on_select

      def refresh
        window = LessCurse.screen.windows[self]

        LessCurse::Renderer::box_with_title window, @title

        @data.each_with_index do |d, idx|
          #FFI::NCurses.mvwaddstr(window, idx + 1, 1, d.to_s)
          FFI::NCurses.wmove window, idx + 1, 1
          FFI::NCurses.waddstr window, d.to_s
        end
      end
    end
  end
end
