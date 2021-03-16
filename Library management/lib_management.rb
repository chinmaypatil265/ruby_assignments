require 'json'
require 'io/console'

class User
    def register_user           #currently working here...............
        registrationflag=false
        puts "Enter user id :"
        id=gets.chomp
        puts "Enter email id :"
        email=gets.chomp
        file=File.read('./user.json')
        hash=JSON.parse(file)
        hash.each do |user|
            if user["user_email"]==email || user["user_id"]==id
                registrationflag=true
                break
            end
        end
        if registrationflag==true
            puts "User email or id already exists!!"
        end
        if registrationflag==false
            puts "Enter a password :"
            pass=gets.chomp
            user_hash=Hash.new
            user_hash["user_id"]=id
            user_hash["user_email"]=email
            user_hash["user_password"]=pass
            hash << user_hash
            File.write('./user.json',JSON.dump(hash))
            puts "Registration successful!!"
        end
    end

end

class Admin

    def list_books                        #List_Books function starts here..
        file=File.read('./user_book.json')
        hash=JSON.parse(file)
        hash.each do |user|
            puts "USERID :#{user["user_id"]} -> ISBN :#{user["isbn"]}"
            puts "------------------------"
        end
    end

    def add_book
        newhash=Hash.new
        print "Enter the isbn code :"
        isbn=gets.chomp
        newhash["isbn"]=isbn
        puts
    
        print "Enter the Author :"
        author=gets.chomp
        newhash["author"]=author
        puts
    
        print "Enter the Book title :"
        title=gets.chomp
        newhash["books"]=title
        puts
    
        print "Enter the quantity :"
        quantity=gets.chomp.to_i
        newhash["quantity"]=quantity
        puts
    
        file=File.read('./books.json')
        hash=JSON.parse(file)
    
        hash << newhash
    
        File.write('./books.json',JSON.dump(hash))
    end
    
    def update_book
        print "Enter the isbn of book that needs to be updated :"
        isbn=gets.chomp
    
        file=File.read('./books.json')
        hash=JSON.parse(file)
    
        print "Enter the field you want to modify :"
        field=gets.chomp.downcase
    
        print "Enter the value :"
        if(field=="quantity")
          value=gets.chomp.to_i
        else
          value=gets.chomp
        end
        hash.each do |book|
            if book["isbn"]==isbn
            book[field]=value
            File.write('./books.json',JSON.dump(hash))
            break
            end
        end
    end
    
    def delete_book
        print "Enter the isbn of book that needs to be deleted :"
        isbn=gets.chomp
    
        file=File.read('./books.json')
        hash=JSON.parse(file)
    
        hash.each do |book|
          if book["isbn"]==isbn
            hash.delete(book)
            File.write('./books.json',JSON.dump(hash))
          end
        end
    end

end

class Book

    def list_books
        puts "Lists of Books"
        puts "-------------------------------"
        file=File.read('./books.json')
        hash=JSON.parse(file)
        hash.each do |book|
        puts "ISBN :#{book["isbn"]}\nBook :#{book["books"]} \nAuthor :#{book["author"]} \nQuantity Available :#{book["quantity"]}"
        puts "-------------------------------"
        end
    end

    def check_valid_user(userid,isbn)
        flag=false
        file_user=File.read('./user_book.json')
        hash_user=JSON.parse(file_user)
        hash_user.each do |user|
            if user["user_id"]==userid && user["isbn"]==isbn
                hash_user.delete(user)
                File.write('./user_book.json',JSON.dump(hash_user))
                flag=true
                break
            else
                flag == false
            end
        end
        if flag == true
            return true
        else
            return false
        end
    end

    def return_book(userid)
        isbnflag=false
        puts "Book Return"
        print "Enter the ISBN code :"
        isbn=gets.chomp
        result=check_valid_user(userid,isbn)
        if result == true
            #Book return login                   
            file=File.read('./books.json') 
            hash_return=JSON.parse(file)
            hash_return.each do |book|
                if book["isbn"]==isbn
                    book["quantity"]+=1
                    File.write('./books.json',JSON.dump(hash_return))
                    puts "Return Successful"
                    isbnflag=true
                    break;
                else
                    isbnflag=true
                    #puts "Your entered ISBN  is invalid"
                end
            end
            puts "ISBN not valid" if isbnflag == false
        end#if result == true end
        puts "Entry not valid" if result == false
        
        return
    end

    def user_book_entry(userid,bookisbn)

        entry_hash=Hash.new
        entry_hash["user_id"]=userid
        entry_hash["isbn"]=bookisbn
  
        file_user=File.read('./user_book.json')
        hash_user=JSON.parse(file_user)
  
        hash_user << entry_hash
  
        File.write('./user_book.json',JSON.dump(hash_user))

    end

    def borrow_book(userid)
        bookflag=false
        puts "Enter the ISBN code for the book you want to borrow :"
        bookisbn=gets.chomp
        file=File.read('./books.json') 
        hash_books=JSON.parse(file)
        hash_books.each do |book|
            if book["isbn"]==bookisbn && book["quantity"]>0
                book["quantity"]-=1
                File.write('./books.json',JSON.dump(hash_books))
                bookflag=true
                puts "Thank you for borrowing the book!!"
                user_book_entry(userid,bookisbn)
                break
            else
                bookflag=false
            end

        end
        puts "Book doesn't exist in our inventory" if bookflag==false

    end

end


def login(login_user)
    login_flag=false
    puts "Enter password :"
    login_pass = gets.chomp

    file_user=File.read('./user.json')
    hash_user=JSON.parse(file_user)

    hash_user.each do |user|
        if user["user_id"]==login_user && user["user_password"]==login_pass
            login_flag=true
            break
        else
            login_flag=false
        end
    end

    if login_flag == true
        return true
    else
        return false
    end

end

#ADMIN MENU
def admin_menu
    print "Enter your email address :"
    email=gets.chomp
    print "Enter password :"
    password = STDIN.noecho(&:gets).chomp
    if email=="admin" && password=="admin"
      puts "\nAdmin Login Successful!!"
      adminchoice=0
      while adminchoice != 5 do
      puts "\nAdmin Menu"
      puts "1.Add new book to inventory"
      puts "2.Delete a book from inventory"
      puts "3.Update a book from inventory"
      puts "4.List of borrowed books"
      puts "5.Exit"
      print "Enter your choice :"
      adminchoice=gets.chomp.to_i

      case adminchoice
      when 1
        admin=Admin.new
        admin.add_book
        puts "Added book successfully"
      when 2
        admin=Admin.new
        admin.delete_book
        puts "Deleted book successfully"
      when 3
        admin=Admin.new
        admin.update_book
        puts "Updated book successfully"
      when 4
        admin=Admin.new
        admin.list_books
      when 5
        break
      else
        puts "Invalid option selected"
      end       #case ends here

      end  #admin select while loop ends here
    else
      puts "\nLogin failed"
    end
end


#USER MENU
def user_menu(userid)
    user_menu_choice=0
    while user_menu_choice != 3
        puts "1.Available Books to Borrow"
        puts "2.Return book"
        puts "3.Logout"
        print "Enter your choice :"
        user_menu_choice = gets.chomp.to_i
        case user_menu_choice
        when 1
            puts "Borrow"
            b=Book.new
            b.list_books
            user_borrow_choice=0
            while user_borrow_choice != 2
                puts "1. Borrow a Book"
                puts "2. Exit"
                print "Enter your choice :"
                user_borrow_choice = gets.chomp.to_i
                case user_borrow_choice
                when 1
                    puts "Available borrow"
                    puts userid
                    b.borrow_book(userid)
                when 2
                    break
                end
            end


        when 2
            puts "Return"
            b=Book.new
            b.return_book(userid)

        when 3
            break
        else
            puts "Invalid choice"

        end
    end

end




choice=0
while choice !=4 
    puts "\n\nWelcome to Library Management System"
    puts "1.User Login"
    puts "2.Admin Login"
    puts "3.Register"
    puts "4.Exit"
    print "Enter your choice :"
    choice = gets.chomp.to_i

    case choice
    when 1
        puts "Enter User-ID:"
        userid=gets.chomp
        if login(userid)
        user_menu(userid)
        else
            puts "Failed"
        end
    when 2
        admin_menu
    when 3
        user=User.new
        user.register_user
    when 4
        puts "Thank you for usinging our Library Management portal.See you soon!!"
        break
    else
        puts "Invalid Option selected"
    end
end

