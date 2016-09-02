#!/usr/bin/env ruby
# Released under the GPLv3+, Copyright 2016 Felix Wolfsteller

require 'less_curse'

# Display list items
simple_list = [1, 2, 3, 4, 5, 6, 7]

list_ui = LessCurse::List
list_ui.data = simple_list
list_ui.on_select = LessCurse::Actions::QUIT

LessCurse.screen.add list_ui
LessCurse.show_screen

# Display hash items
simple_hash = {rainbows: "fabolous",
               unicorns: "magnificient",
               sunrise:  "fantastic",
               sunset:   "marvellous"}

list_ui.data = simple_hash
LessCurse.show_screen
