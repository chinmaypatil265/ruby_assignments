module Operationable

  def display_menu
    puts "1. Insert data"
    puts "2. Update data"
    puts "3. Delete data"
    puts "4. Display data"
    puts "5. Exit"
    print "Enter your choice :"
  end

  def retrieve(array)
    array.each{|hash| puts hash}
  end

  def update(array, userid)
    entry = array.select{|hash| hash["id"] == userid}
    entry[0].each do |k,v|
      puts "#{k} : #{v}"
      print "Do you want to update ? (Y/N): "
      case gets.chomp
      when 'Y'||'y'
        print "Enter new value for #{k}: "
        entry[0][k]=gets.chomp
        puts "Update Successful!!"
      end
    end
    puts "Updated entry is: #{entry}"
  end

  def delete(array, userid)
    array.delete_if{|hash| hash["id"] == userid}
  end

 

  def insert(array)
    array << self.accept
  end


end



class User
  attr_accessor :id, :name, :age
  
  include Operationable

  def accept
    input_user_hash=Hash.new
    print "Enter user id: "
    input_user_hash["id"] = gets.chomp.to_i
    print "Enter Name: "
    input_user_hash["name"] = gets.chomp
    print "Enter Age: "
    input_user_hash["age"] = gets.chomp.to_i
    return input_user_hash
  end

end

class Address
  attr_accessor :user, :city, :state, :pin
  
  include Operationable
  
  def accept
    input_address_hash=Hash.new
    print "Enter User Id: "
    input_address_hash["userid"] = gets.chomp
    print "Enter city: "
    input_address_hash["city"] = gets.chomp
    print "Enter state: "
    input_address_hash["state"] = gets.chomp
    print "Enter pin Code: "
    input_address_hash["pin"] = gets.chomp
    return input_address_hash
  end
end

class Main
  user_arr=Array.new
  address_arr=Array.new

  extend Operationable

  while 1
    puts "1. To Enter User Details"
    puts "2. To Enter Address Details"
    puts "3. Exit"
    puts "Enter your choice:  "
    case gets.chomp.to_i
    when 1
      display_menu
      case gets.chomp.to_i
        when 1
          u = User.new
          u.insert(user_arr)
        when 2
          print "Enter user id: "
          update(user_arr, gets.chomp.to_i)
        when 3
          print "Enter user id: "
          delete(user_arr, gets.chomp.to_i)
        when 4
          retrieve(user_arr)
        when 5
          break
      end
    when 2
      display_menu
      case gets.chomp.to_i
        when 1
          a=Address.new
          a.insert(address_arr)
        when 2
          print "Enter user id: "
          update(address_arr, gets.chomp.to_i)
        when 3
          print "Enter user id: "
          delete(address_arr, gets.chomp.to_i)
        when 4
          retrieve(address_arr)
        when 5
          break
      end

    when 3
      break
    end
  end

end
