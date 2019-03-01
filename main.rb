require "date"
require "table_print"

require_relative "lib/user_manager"
require_relative "lib/user"
require_relative "lib/extractor"

include Extractor

user_manager = UserManager.new

user_manager.import("./files/comma_delimited.csv")
user_manager.import("./files/pipe_delimited.txt")
user_manager.import("./files/space_delimited.txt")

users_by_gender         = user_manager.sort_by(:gender)
users_by_date_of_birth  = user_manager.sort_by(:date_of_birth)
users_by_last_name_desc = user_manager.sort_by(:last_name_desc)

puts "\n\n"
puts "+---------------------------------------------------+"
puts "| OUTPUT 1: sorted by gender (females before males) |"
puts "|           then by last name ascending             |"
puts "+---------------------------------------------------+\n\n"
user_manager.print(users_by_gender)

puts "\n\n"
puts "+---------------------------------------------------+"
puts "| OUTPUT 2: sorted by birth date, ascending         |"
puts "+---------------------------------------------------+\n\n"
user_manager.print(users_by_date_of_birth)

puts "\n\n"
puts "+---------------------------------------------------+"
puts "| OUTPUT 3: sorted by last name, descending         |"
puts "+---------------------------------------------------+\n\n"
user_manager.print(users_by_last_name_desc)
