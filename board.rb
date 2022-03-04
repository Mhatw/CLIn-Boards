require_relative 'list'

class Board
  
  def initialize

  end
  
  def create
    print "Name: "
    board_name = GetInput.get_input("")
    print "Description: "
    description_name = GetInput.get_input("")
    # transform in hash and push

    show_board
  end

  def show_board
    board = Terminal::Table.new
    board.title = "CLIn Boards"
    board.headings = ['ID', 'Name', 'Description', 'List(#cards)']
    board.rows = $global_data.map do |pl, ga = pl["lists"].map do |a|
      a["name"] + "(" + a["cards"].size.to_s + ")"end|
      [pl["id"], pl["name"], pl["description"], ga.join(", ")]
    end
    puts board
  end
  
  def show_board_details(id)
    puts "show_board_details"
    List.new(id)

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