class ScoreKeeper

  #a method to make the code more readable and thus made the logic easier to reason.
  #it returns the appropriate number based on the position in input
  def convert_to_number(input,position)
    return 10 if input[position] == ("x") || input[position] == ("/")
    return 0 if input[position] == ("-")
    return input[position].to_i
  end

  #finds the amount of frames taken up during a game of bowling
  #a game of bowling can only take 20 or 21 frames to complete
  def compute_number_of_throws(input)
    adjusted_game_length = 0
    (0..input.length-1).each do |char|
      if adjusted_game_length < 17

        if input[char] == "x"
          adjusted_game_length +=2
        else adjusted_game_length += 1

        end

      else adjusted_game_length += 1

      end

    end
    return adjusted_game_length
  end


  def calculate(input)
    #raises error if the game is not the correct length
    raise ArgumentError, 'Input is invalid' if !compute_number_of_throws(input).between?(20,21) || (compute_number_of_throws(input) == 20 && input[input.size - 1] == "/")

    number_of_throws = 0
    score = 0

    (0..input.length-1).each do |throw|
    input[throw].downcase #incase of an accidental X input

    if number_of_throws < 18 #after the 18th throw use special 10th frame scoring


      #strike
      if input[throw] == "x"

        #if a strike then a spare
        if input[throw + 2] == "/"
          score += convert_to_number(input,throw) + convert_to_number(input,throw + 2)
          number_of_throws += 2

        else
          score += convert_to_number(input,throw) + convert_to_number(input,throw + 1) + convert_to_number(input,throw + 2)
          number_of_throws += 2
        end
      #spare
      elsif input[throw] == "/"
        score += convert_to_number(input,throw) + convert_to_number(input,throw + 1) - convert_to_number(input,throw - 1)
        number_of_throws += 1


      else score += convert_to_number(input,throw) ; number_of_throws += 1

      end



      #the 10th frame scoring rules
    else
      #strike
      if input[throw] == "x"
        score += convert_to_number(input,throw)
        number_of_throws += 1
      #spare
      elsif input[throw] == "/"
        score += convert_to_number(input,throw) - convert_to_number(input,throw - 1)

        number_of_throws += 1

      else score += convert_to_number(input,throw)
      number_of_throws += 1

      end


    end

    #check for an impossible roll combination like "999" or two spares "/" "/" in a row in the first and second rolls of a frame
    if number_of_throws.odd? && input[throw] != "x"
      raise ArgumentError, 'Impossible roll Detected' if input[throw] == "/"
      raise ArgumentError, 'Impossible roll Detected' if input[throw + 1] != "/" && convert_to_number(input,throw) + convert_to_number(input,throw + 1) > 9 #only do the check if a spare isn't the second throw
    end

    end

    return score
  end
end
