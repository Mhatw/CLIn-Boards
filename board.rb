require_relative 'list'
require 'json'

class Board
  
  def initialize
    
  end
  
  def create
    print "Name: "
    board_name = GetInput.get_input("")
    print "Description: "
    description_name = GetInput.get_input("")
    # transform in hash and push
    params_map = {}
    params_map["id"] = $global_data.size.next
    params_map["name"] = board_name
    params_map["description"] = description_name
    params_map["lists"] = []
    $global_data.push(params_map)
    $global_data
    # json = JSON.pretty_generate(data_hash)
    # File.open("prueba.json","w") do |f|
    # f.write(json)
    # end
    show_board
  end

  def show_board
    board = Terminal::Table.new
    board.title = "CLIn Boards"
    board.headings = ['ID', 'Name', 'Description', 'List(#cards)']
    board.rows = $global_data.map do |pl, ga = pl["lists"].map do |a|
      a["name"] + ("(" + a["cards"].size.to_s + ")") if !a["cards"].empty? end|
      [pl["id"], pl["name"], pl["description"], ga.join(", ")]
    end
    puts board
  end
  
  def show_board_details(id)
    puts "show_board_details"
    List.new(id)
    show_board


  end

  def update_board(id)
    print "Name: "
    board_name = GetInput.get_input("")
    print "Description: "
    description_name = GetInput.get_input("")
    # replace informacion del hash
    $global_data.each do |n| 
      if n["id"] == id.to_i 
        n["name"] = board_name
        n["description"] = description_name
      end
    end
    show_board
  end

  def delete_board(id)
    puts "delete_board"
    $global_data.delete_if { |n| n["id"] == id.to_i }
    show_board
  end

end