
=begin
----Notes

----Strike
    count next two rolls, except in 10th frame
    cannot frame with strike, except in 10th frame
    
----Spare
    Count next roll, except in 10th frame
    cannot start frame with spare

----Frame Errors

    [/,%] - cannot start with spare
    [number,x], [-,x]  - cannot end with strike
    [X,Y] where y >= 10 - x - cannot have more than 10 pins
=end

class ScoreKeeper
    
    def calculate(input)
        #init variables
        totalScore = 0
        currentFrame = 1
        currentThrow = 1
        allowThirdThrow = false
        
        #loop through provided bowling string
        input.split("").each_with_index do |value,index|
            
            #make sure the current vale is a valid throw
            checkForValidThrow(input,index,currentFrame,currentThrow)
            
            #Get the clean score for this throw, and increment total score
            totalScore += getCleanScore(input,index)
            
            #logic for all frames except the 10th frame
            if currentFrame != 10
                case value
                    #strike logic, get clean score for next two throws and skip to next frame
                    when "x"
                        totalScore += getCleanScore(input, index+1)
                        totalScore += getCleanScore(input, index+2)
                        currentThrow = 1
                        currentFrame+=1
                        next
                    #spare logic, get clean score for next throw
                    when "/"
                        totalScore += getCleanScore(input, index+1)
                end
                #Logic for keeping track of what throw we are on
                case currentThrow
                    when 1
                        currentThrow = 2
                    when 2
                        currentThrow = 1
                        currentFrame+=1
                        next
                end
            # logic for the 10th frame
            else
                 case currentThrow
                    #if we get a strike on the first throw we can roll three times
                    when 1
                        currentThrow = 2
                        if value == "x"
                            allowThirdThrow = true
                        end
                    #if we get a spare on the second throw we can roll three times
                    when 2
                        currentThrow = 3
                        if value == "/"
                            allowThirdThrow = true
                        end
                        
                        
                    when 3
                        #set current throw to -1 to easily check that the third trhow was thrown
                        currentThrow = -1
                        if !allowThirdThrow
                            raise "Third throw not allowed"
                            next
                        end
                    #if we have already  our third throw
                    when -1 
                        raise "too many throws"
                end
            end
            
        end
        
        #Check for final Errors
        if currentFrame < 10 
            raise "not enough input for a complete game"
        end
        
        #check if third throw was thrown
        if currentThrow == 3 and allowThirdThrow
            raise "Never threw third throw"
        end
        
        return totalScore
    end
  
    def checkForValidThrow(input, position,currentFrame,currentThrow)
        #Make sure we have enough input
        if input[position].nil?
            raise  "not enough input for a complete game" + input
        end
        
        value = input[position]
        #check for errors
        case currentThrow
            when 1
                if value == '/'
                    raise "You cannot have a spare on the first throw"
                end
            when 2 
            
                if currentFrame != 10 and value == 'x'
                    raise "You cannot have a Strike on the second throw"
                end
                
                if value != "x" and getCleanScore(input,position) + getCleanScore(input,position -1) > 10
                    raise "More than 10 pins on frame " + currentFrame.to_s + " from input " + input.to_s
                end
        end
        
    end
    #should return a clean score (INT) for a single value
    def getCleanScore(input, position)
        value = input[position]
        case value
            when /^[0-9]$/
                cleanScore = Integer(value)
            when "-"
                cleanScore = 0
            when "x"
                cleanScore = 10
            when "/"
                cleanScore = 10 - Integer(input[position - 1])
            else
                raise '"'+ value + '" is not a valid entry'  
        end
        return cleanScore
    end 
end

