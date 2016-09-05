#!/usr/bin/env ruby
# Released under the GPLv3+, Copyright 2016 Felix Wolfsteller

require 'less_curse'

begin
# Display list items
simple_list = [1, 2, 3, 4, 5, 6, 7]

list_ui = LessCurse::Widgets::List.new
list_ui.data = simple_list
list_ui.on_select = LessCurse::Actions::QUIT

LessCurse.screen.add list_ui
LessCurse.show_screen
LessCurse.enter_loop!

# Display hash items
simple_hash = {rainbows: "fabolous",
               unicorns: "magnificient",
               sunrise:  "fantastic",
               sunset:   "marvellous"}

list_ui.data = simple_hash
list_ui.title = "Hash keys"

textview_ui = LessCurse::Widgets::TextView.new title: 'TextView',
                                               data: "Showing Text Data\nSecond Line of Text Data"

LessCurse.screen.add textview_ui
LessCurse.show_screen
LessCurse.enter_loop!

LessCurse.screen.windows.each do |widget, window|
  puts "#{widget} -> #{window}"
end

ensure
LessCurse.close_screen
end
