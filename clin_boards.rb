require "json"
require "terminal-table"
require_relative "get_input"
require_relative "board"
require_relative "validations"
include GetInput
include Validations

$global_data = JSON.parse(File.read('store.json'))
p "###############"
p $global_data[0]["lists"].size.next
# $global_data[@id_list]["lists"].size.next
# $global_data.each { |n| pp n if n["id"] == 1 }
class ClinBoards
  def initialize
    # Complete this
    @principal_board = Board.new
    
  end
  
  def start
    prompt_sf("Welcome to CLIn Boards")
    @principal_board.show_board
    GetInput.get_action_board
    @action = GetInput.get_input("> ")
    until_action
    prompt_sf("Thanks for using CLIn Boards")
  end

  # genera el loop del menu
  def until_action
    until @action == "exit"

      if @action == "create"
        @principal_board.create

      elsif @action.include? "show"
        id = GetInput.get_id(@action)
        Validations.valid_list_id(id) == true ? @principal_board.show_board_details(id) : (puts "please enter a valid ID")

        

      elsif @action.include? "update"
        id = GetInput.get_id(@action)
        Validations.valid_list_id(id) == true ? @principal_board.update_board(id) : (puts "please enter a valid ID")
        

      elsif @action.include? "delete"
        id = GetInput.get_id(@action)
        Validations.valid_list_id(id) == true ? @principal_board.delete_board(id) : (puts "please enter a valid ID")
        

      else
        puts "please type good" #poner un mensaje mas piola
      end

      GetInput.get_action_board
      @action = GetInput.get_input("> ")
    end
  end

  # imprime el prompt inicial y final
  def prompt_sf(prompt)
    prompt.size < 34 ? space = (34 - prompt.size) / 2 : space = 0
    puts "#{"#" * 36}\n##{" " * space}#{prompt}#{" " * space}#\n#{"#" * 36}"
  end

end

app = ClinBoards.new
app.start

