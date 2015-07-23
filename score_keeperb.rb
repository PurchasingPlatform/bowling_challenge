class ScoreKeeper

  #a method to make the code more readable and make the logic easier
  #it returns the appropriate number based on the position in input
  def convert_to_number(input,position)
    return 10 if input[position] == ("x") || input[position] == ("/")
    return 0 if input[position] == ("-")
    return input[position].to_i
  end

  #finds the amount of frames taken up during a game of bowling
  #a game of bowling can take up to 20 or 21 frames to complete
  def compute_game_length(input)
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
    raise ArgumentError, 'Input is invalid' if !compute_game_length(input).between?(20,21) || (compute_game_length(input) == 20 && input[input.size - 1] == "/")

    number_of_throws = 0
    score = 0

    (0..input.length-1).each do |throw|
     #input[throw].downcase #just in case of "X"

    if number_of_throws < 18 #after the 16th throw use special 10th frame scoring



      if input[throw] == "x"

        if input[throw + 2] == "/"
          score += convert_to_number(input,throw) + convert_to_number(input,throw + 2)
          number_of_throws += 2

        else
          score += convert_to_number(input,throw) + convert_to_number(input,throw + 1) + convert_to_number(input,throw + 2)
          number_of_throws += 2
        end

      elsif input[throw] == "/"
        score += convert_to_number(input,throw) + convert_to_number(input,throw + 1) - convert_to_number(input,throw - 1)
        number_of_throws += 1


      else score += convert_to_number(input,throw) ; number_of_throws += 1

      end

      if number_of_throws.odd? && input[throw] != "x"
        raise ArgumentError, 'Impossible roll Detected' if input[throw] == "/"
        raise ArgumentError, 'Impossible roll Detected' if input[throw + 1] != "/" && convert_to_number(input,throw) + convert_to_number(input,throw + 1) > 9
      end

    else

      if input[throw] == "x"
        score += convert_to_number(input,throw)
        number_of_throws += 1

      elsif input[throw] == "/"
        score += convert_to_number(input,throw) - convert_to_number(input,throw - 1)
        #score += convert_to_number(input,throw + 1) if input[throw + 1] != nil
        number_of_throws += 1

      else score += convert_to_number(input,throw)
      number_of_throws += 1

      end

      if number_of_throws.odd? && input[throw] != "x"
        raise ArgumentError, 'Impossible roll Detected' if input[throw] == "/"
        raise ArgumentError, 'Impossible roll Detected' if input[throw + 1] != "/" && convert_to_number(input,throw) + convert_to_number(input,throw + 1) > 9
      end
    end

    end

    return score
  end
end
