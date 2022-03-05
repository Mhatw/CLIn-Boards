class List

  def initialize(id)
    @id = id.to_i - 1
    show_list

    # @pos = ""
    # $global_data.each { |n| @pos = n if n["id"] == id.to_i }
    # @pos
    
  end

  def show_list
    puts @id
    puts $global_data[@id]

  end

  

end