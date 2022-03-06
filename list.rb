require_relative "get_input"
require_relative "checklist"
require_relative "cards"

class List
  
  def initialize(id)
    @id_list = id.to_i - 1
    $global_data[@id_list]["lists"].empty? ? GetInput.empty_message : show_list
    $global_data[@id_list]["name"] == "Extended - CLIn Boards" ? @@id_card = 9 : @@id_card = 0
    start_list    
    # @pos = ""
    # $global_data.each { |n| @pos = n if n["id"] == id.to_i }
    # @pos
    
  end
  def start_list

    GetInput.get_action_lists
    @action = GetInput.get_input("> ")
    until_action

  end

  def show_list
    $global_data[@id_list]
    $global_data[@id_list]["lists"].each do |pa|
    board = Terminal::Table.new
    board.title = pa["name"]
    board.headings = ['ID', 'Title', 'Members', 'Labels', 'Due Date', 'Checklist']
    if !pa["cards"].empty?
      board.rows = pa["cards"].map do |pl|
      [pl["id"], pl["title"], pl["members"].join(", "), pl["labels"].join(", "), pl["due_date"], "#{ count_true(pl) }/#{pl["checklist"].size}"]
      end
    end
    puts board
    end
  end
  
  def count_true(pl)
    count = 0
    if !pl["checklist"].empty?
      pl["checklist"].each do |n|
      count += 1 if n["completed"] == true
      end
    end
    count
  end

  # List options: create-list | update-list LISTNAME | delete-list LISTNAME
  # Card options: create-card | checklist ID | update-card ID | delete-card ID

  def until_action
    until @action == "back"

      if @action == "create-list"
        create_list
        
      elsif @action.include? "update-list"
       
        list_action = GetInput.get_list_action(@action)
        Validations.valid_list_name(list_action, @id_list) ? update_list(list_action) : (puts "please enter a valid LISTNAME")
        
        
      elsif @action.include? "delete-list"
        
        list_action = GetInput.get_list_action(@action)
        Validations.valid_list_name(list_action, @id_list) ? delete_list(list_action) : (puts "please enter a valid LISTNAME")
      
      elsif @action == "create-card"
        $global_data[@id_list]["lists"].size.positive? ? create_card : GetInput.empty_message
      
      elsif @action.include? "checklist"
        
        list_action = GetInput.get_id(@action)
        Validations.valid_id_card(list_action, @id_list) ? Checklist.new : (puts "please enter a valid CARD ID")
        #tengo que validar id de card
      elsif @action.include? "update-card"
      
        list_action = GetInput.get_id(@action)
        count = ""
        $global_data[@id_list]["lists"].each { |n| count = [n["id"],n["name"]] if lalistaa(n, list_action) == true }
        !count.empty? ? update_card(list_action, count) : (puts "please enter a valid CARD ID")
      
      elsif @action.include? "delete-card"
        list_action = GetInput.get_id(@action)
        count = ""
        $global_data[@id_list]["lists"].each { |n| count = [n["id"],n["name"]] if lalistaa(n, list_action) == true }
        !count.empty? ? delete_card(list_action, count) : (puts "please enter a valid CARD ID")
      
      else
        puts "please type good" #poner un mensaje mas piola
      end
      
      GetInput.get_action_lists
      @action = GetInput.get_input("> ")
    end
  end
  def delete_card(list_action, count)
    $global_data[@id_list]["lists"][count[0]-1]["cards"].delete_if { |n| n["id"] == list_action.to_i }
    show_list
  end

  def update_card(list_action, count)
    params_map = {}
    params_map["id"] = list_action
    arr = []
    $global_data[@id_list]["lists"].each {|n| arr.push(n["name"])}
    puts "Select a list: \n#{arr.join(" | ")}"
    update_card_action = GetInput.get_input("> ")
    print "Title: "
    params_map["title"] = GetInput.get_input("")
    print "Members: "
    params_map["members"] = GetInput.get_input("").split(", ")
    print "Labels: "
    params_map["labels"] = GetInput.get_input("").split(", ")
    print "Due Date: "
    params_map["due_date"] = GetInput.get_input("")
    params_map["checklist"] = []
    params_map
    p list_action.to_i
    $global_data[@id_list]["lists"][count[0]-1]["cards"].delete_if { |n| n["id"] == list_action.to_i }
    $global_data[@id_list]["lists"].each { |n| n["cards"].push(params_map) if n["name"] == update_card_action }
    show_list
  end

  def lalistaa(n, list_action)
    count = false
    if !n["cards"].empty?
      n["cards"].each do |nl|
      count = true if nl["id"] == list_action.to_i
      nl["id"]
      end
    end
    count
  end


  def create_card
    arr = []
    $global_data[@id_list]["lists"].each {|n| arr.push(n["name"])}
    puts "Select a list: \n#{arr.join(" | ")}"
    create_card_action = GetInput.get_input("> ")
    validation = Validations.valid_name_card(arr, create_card_action)
    validation ? create_card_2(create_card_action) : GetInput.empty_card_message
  end

  def create_card_2(action)
    params_map = {}
    params_map["id"] = @@id_card += 1 
    print "Title: "
    params_map["title"] = GetInput.get_input("")
    print "Members: "
    params_map["members"] = GetInput.get_input("").split(", ")
    print "Labels: "
    params_map["labels"] = GetInput.get_input("").split(", ")
    print "Due Date: "
    params_map["due_date"] = GetInput.get_input("")
    params_map["checklist"] = []
    $global_data[@id_list]["lists"].each { |n| n["cards"].push(params_map) if n["name"] == action  }
    show_list
  end

  

  def create_list
    print "Name: "
    list_name = gets.chomp
    params_map = {}
    params_map["id"] = 1
    params_map["name"] = list_name
    params_map["cards"] = []

    $global_data[@id_list]["lists"].push(params_map)
    # $global_data

    show_list
  end

  def update_list(list_action)
    print "Name: "
    list_name = gets.chomp
    $global_data[@id_list]["lists"].each do |n| 
      if n["name"] == list_action
        n["name"] = list_name
      end
    end
    show_list
  end

  def delete_list(list_action)
    $global_data[@id_list]["lists"].delete_if { |n| n["name"] == list_action }
    show_list
  end

  

end