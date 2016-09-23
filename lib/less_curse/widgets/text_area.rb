module LessCurse
  module Widgets
    class TextArea < Base
      def refresh
        window = LessCurse.screen.windows[self]

        LessCurse::Renderer::bold_if(focused?, window) do
          LessCurse::Renderer::box_with_title window, @title
        end
        FFI::NCurses.wmove window, 1, 1
        @data.to_s.split("\n").each_with_index do |line, idx|
          FFI::NCurses.mvwaddstr window, idx + 1, 1, line
        end
      end

      def handle_input key
        # Its a PITA to redo all the readline loveliness, but it gets us right
        # into doing things.  Would be cool to have moving cursor on ENTER
        if key == FFI::NCurses::KEY_BACKSPACE
          @data = @data[0..-2]
        else
          # Handle out of range stuff
          @data += key.chr rescue false
        end
      end

      def focus
        @focus = true
        ## Initial experiments where done with cbreak and echo
        #FFI::NCurses.echo
        #FFI::NCurses.nocbreak # can ctrl-c, not waiting for newlines to end input.
        ##@data = ... but master.refresh afterwards ..
        #window = LessCurse.screen.windows[self]
        ##FFI::NCurses::mvwgetstr window, 4, 3, @data
        ##@data += FFI::NCurses::wget_wstr window
        #@data += FFI::NCurses::wgetch(window).chr
        ## from ffi/ncurses getkey example
        # #buffer = FFI::Buffer.new(FFI::NCurses.find_type(:wint_t))
        refresh
      end
    end
  end
end

