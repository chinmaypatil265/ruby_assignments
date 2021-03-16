class Students

   @roll_no
   @marks
   @result
   @sum
   
 
  
  attr_accessor :rollno,:marks,:percentage
  
  def initialize(roll_no,marks)
    @roll_no=roll_no
    @marks=marks
    @sum=0
    @result=2
 
  end

  
  def calc_percentage(n)
    @marks.each{ |mark| @sum=@sum + mark }
    @result=(@sum/(n*100).to_f)*100
    puts "Percentage is #{@result}"
  
  end
    
    


end

puts "Enter Roll No. "
name=gets.chomp
marks = []
puts "Enter number of subjects"
n=gets.chomp
i=0
n=n.to_i
while i<n
  puts "Enter marks of subject #{i+1}"
  marks[i]=gets.chomp.to_i
  i=i+1
end

s1 = Students.new(name,marks)
per=s1.calc_percentage(n)

