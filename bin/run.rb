
#!/usr/bin/env ruby

require_relative "api_communicator.rb"
require_relative "command_line_interface.rb"

welcome
character = get_character_from_user
show_character_movies(character)
