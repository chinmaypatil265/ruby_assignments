def isPrime(number)
	if number == 2
		return p "#{number} is prime"
	end
		
	if number == 1
		return p "#{number} is neither prime nor composite"
	end

	var = 2

	while var <= number/2
		if number%var==0
			return p "#{number} is not prime"
		else
			flag=true;
		end

		if flag==true
			return p "#{number} is prime"
		end

		var=var+1

	end

end

isPrime(23)
isPrime(2)
isPrime(1)

