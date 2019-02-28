require "date"
require "pp"

require_relative "lib/user_manager"
require_relative "lib/user"
require_relative "lib/extractor"

include Extractor

user_manager = UserManager.new

user_manager.import("./files/comma_delimited.csv")
user_manager.import("./files/pipe_delimited.txt")
user_manager.import("./files/space_delimited.txt")

user_manager.sort_by(:gender)
user_manager.sort_by(:date_of_birth)
user_manager.sort_by(:last_name_desc)