class Checklist

  def initialize(id, list_action, count)
    @id_list = id
    @id = list_action
    @count = count

    show
    GetInput.get_action_checklist
    until_checklist


  end

  def until_checklist
    # Checklist options: add | toggle INDEX | delete INDEX

    @action = GetInput.get_input("> ")
    until @action == "back"
  
      if @action == "add"
        add_checklist
        
      elsif @action.include? "toggle"
      theindex = GetInput.get_id(@action)
      if theindex.to_i <= $global_data[@id_list]["lists"][@count[2]]["cards"][@dato]["checklist"].size 
        toggle(theindex)
      else
        puts "please enter a valid INDEX"
      end

      elsif @action.include? "delete"
        theindex = GetInput.get_id(@action)
        if theindex.to_i <= $global_data[@id_list]["lists"][@count[2]]["cards"][@dato]["checklist"].size 
          delete_ck(theindex)
        else
          puts "please enter a valid INDEX"
        end

      else
        puts "please type good"
      end
      GetInput.get_action_checklist
      @action = GetInput.get_input("> ")
    end


  end
  def toggle(theindex)
    varr = $global_data[@id_list]["lists"][@count[2]]["cards"][@dato]["checklist"][theindex.to_i-1]["completed"] 
    varr == true ? varr = false : varr = true 
    $global_data[@id_list]["lists"][@count[2]]["cards"][@dato]["checklist"][theindex.to_i-1]["completed"] = varr
    show
  end
  def delete_ck(theindex)
    $global_data[@id_list]["lists"][@count[2]]["cards"][@dato]["checklist"][theindex.to_i-1].delete_if {|n| true == true}
    show
  end
  
  def add_checklist
    $global_data[@id_list]["lists"][@count[2]]["cards"][@dato]["checklist"]
    ahash = {}
    ahash["title"] = GetInput.get_input("Title: ")
    ahash["completed"] = false
    $global_data[@id_list]["lists"][@count[2]]["cards"][@dato]["checklist"].push(ahash)
    show
  end

  def show
    @dato = ""
    $global_data[@id_list]["lists"][@count[2]]["cards"].each { |n| @dato = $global_data[@id_list]["lists"][@count[2]]["cards"].index(n) if n["id"] == @id.to_i }
    puts "Card: #{$global_data[@id_list]["lists"][@count[2]]["cards"][@dato]["title"]}"
    $global_data[@id_list]["lists"][@count[2]]["cards"][@dato]["checklist"].each_with_index do |pe, idx|
      if pe["completed"] == true
      puts "[x] #{idx + 1}. #{pe["title"]}"
      else
      puts "[ ] #{idx + 1}. #{pe["title"]}"
      end
    end
  end


end