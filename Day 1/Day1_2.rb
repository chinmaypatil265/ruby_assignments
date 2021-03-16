def checkGrade(grade)

	if grade>=1 && grade<=5
		return p "Elementary"
	elsif grade>=6 && grade<=8
		return p "Middle School"
	elsif grade>=9 && grade<=12
		return p "High School"
	else
		return p "College"	
	
	end

end


checkGrade(3)
checkGrade(7)
checkGrade(9)
checkGrade(14)
