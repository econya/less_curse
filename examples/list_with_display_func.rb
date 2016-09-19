#!/usr/bin/env ruby
# Released under the GPLv3+, Copyright 2016 Felix Wolfsteller

require 'less_curse'

LessCurse.log_to! $PROGRAM_NAME + ".log"

begin
  # Display hash items
  list_ui = LessCurse::Widgets::List.new
  simple_hash = {rainbows: "fabolous",
                 unicorns: "magnificient",
                 sunrise:  "fantastic",
                 sunset:   "marvellous"}

  list_ui.data = simple_hash
  list_ui.title = "Hash keys"

  list_ui.display_func = lambda {|i| i[0].to_s}

  LessCurse.screen.add list_ui
  LessCurse.show_screen
  LessCurse.enter_loop!
ensure
  LessCurse.close_screen
end
