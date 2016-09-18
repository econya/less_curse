#!/usr/bin/env ruby
# Released under the GPLv3+, Copyright 2016 Felix Wolfsteller

require 'less_curse'

begin
  # Display list items
  simple_list = (1..200).to_a

  list_ui = LessCurse::Widgets::List.new
  list_ui.data = simple_list
  list_ui.on_select = LessCurse::Actions::QUIT

  LessCurse.screen.add list_ui
  LessCurse.show_screen
  LessCurse.enter_loop!
ensure
  LessCurse.close_screen
end
