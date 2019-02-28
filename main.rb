require "date"
require "pp"

require_relative "lib/user_manager"
require_relative "lib/user"
require_relative "lib/extractor"

include Extractor

user_manager = UserManager.new

pp user_manager.import("./files/comma_delimited.csv")
pp user_manager.import("./files/pipe_delimited.txt")
pp user_manager.import("./files/space_delimited.txt")