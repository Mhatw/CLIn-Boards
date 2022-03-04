
module Validations

  def valid_list_id(id)
    valid = false
    $global_data.each { |n| valid = true if n["id"] == id.to_i }
    valid
  end

end