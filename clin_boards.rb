
require "json"
require "terminal-table"
require_relative "get_input"
require_relative "board"
require_relative "validations"
include GetInput
include Validations
# print data_hash

class ClinBoards
  def initialize
    # Complete this
    @@file = File.read('store.json')
    @@data_hash = JSON.parse(@@file)
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

      if @action.include? "create"
        @principal_board.create

      elsif @action.include? "show"
        @principal_board.show_board_details(@action)

      elsif @action.include? "update"
        @principal_board.update_board(@action)

      elsif @action.include? "delete"
        @principal_board.delete_board(@action)

      else
        puts "please type good" #poner un mensaje mas piola
        @action = GetInput.get_input("> ")
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

