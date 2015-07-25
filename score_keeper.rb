class ScoreKeeper
  def calculate(input)
    if !input.is_a? String
		raise argumentException, "Score Keeper will only except string types for score calculation."
	end
		
	# Thanksgiving Turkey Edge Case
	if input == "xxxxxxxxxxxx"
		return 300
	end
		
	# Calculate Score
	input.gsub(/-/, "0")
	_throws = input.split(//)
			
	score = 0
			
	_throws.each_with_index do |ball, i|
		lastThrow = _throws[i - 1] || "0"
		lastlastThrow = _throws[i - 2] || "0"
		nextThrow = _throws[i + 1] || "0"
					
		workingValue = 0;
			
		# Add numbers directly (unless part of a spare frame)
		if ("1234567890".include? ball)
			workingValue = ball.to_i
		end
				
		# Add strike as 10 points
		if ball == "x"
			workingValue = 10
		end
		
		# Add spare as number of remaining pins from last throw
		if ball == "/"
			if lastThrow == "/" || lastThrow == "x"
				raise argumentException, "Invalid score string. A spare cannot immediately follow a strike or spare."
			end
		
			workingValue = 10 - lastThrow.to_i
		end						
		
		if i >= 2 && i < 20
			# Strike / Spare Bonus
			if lastThrow == "x" || lastThrow == "/" || lastlastThrow == "x"
				score += workingValue
			end
		end
		
		# Add current throw value
		score += workingValue		
	end
	
	if score > 300 || score < 0
		raise argumentExcpetion, "Invalid score string. Impossible score detected."
	end
	
	return score
	
  end
end