def begin_game

require 'httparty'

url="https://random-word-api.herokuapp.com/word"

response = HTTParty.get(url)

response.parsed_response

array = response.to_a
str = (array.to_s)

word=str

arr=[]
check_arr=[]
puts str

count=0
hang=0
i=0

while i<str.length-4
  arr.push("_")
  i=i+1
end


while count<str.length-4
  puts
  print "Enter character :"
  v=gets.chomp
  puts

  if word.include?(v)
    while word.include?(v)
    index=str.index(v)
    arr[index-2]=v
    word[index]="-"
    count+=1
    check_arr << v
    end
    print arr
    
elsif check_arr.include?(v)==true
    
    # puts "Lives used #{hang}"
    # print arr

else
    hang+=1
    puts "Lives used #{hang}"
    print arr
  end

  if(hang>5)
    puts 
    puts "YOU LOST!!"
    break;
  end

  
end

if(hang<=5 )
puts 
puts "YOU WON!!"
end

end

nextvar="yes"

while nextvar!="no"
begin_game
print "Do you want to play again (yes/no)"
nextvar=gets.chomp.downcase
puts
end
