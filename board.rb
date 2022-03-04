class Board
  
  def initialize
    @file = File.read('store.json')
    @data_hash = JSON.parse(@file)

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
    table = Terminal::Table.new
    table.title = "CLIn Boards"
    table.headings = ['ID', 'Name', 'Description', 'List(#cards)']
    table.rows = @data_hash.map do |pl, ga = pl["lists"].map do |a|
      a["name"] + "(" + a["cards"].size.to_s + ")"end|
      [pl["id"], pl["name"], pl["description"], ga.join(", ")]
    end
    puts table
  end
  
  def show_board_details(action)
    puts "show_board_details"
    id = GetInput.get_id(action)
    id_validation = Validations.valid_list_id(id)
    id_validation == true ? List.new(id) : (puts "please enter a valid ID")
  end

  def update_board(action)
    puts "update_board"
    id = GetInput.get_id(action)
    id_validation = Validations.valid_list_id(id)
    id_validation == true ? (puts "a borrar") : (puts "please enter a valid ID")

    print "Name: "
    board_name = GetInput.get_input("")
    print "Description: "
    description_name = GetInput.get_input("")

  end

  def delete_board(action)
    puts "delete_board"
    id = GetInput.get_id(action)
    id_validation = Validations.valid_list_id(id)
    id_validation == true ? (puts "a borrar") :( puts "please enter a valid ID")

  end



end