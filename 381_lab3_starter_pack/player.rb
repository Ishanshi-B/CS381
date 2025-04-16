#required
require_relative "element"
require_relative "history"

#Player superclass
class Player
    attr_reader :name, :history

    #constrcutor 
    def initialize(name, history)
        @name = name 
        @history = history
    end

    def play()
        fail "This method should be overridden"
    end
end 

class StupidBot < Player
    def play
        #always play rock
        move = Rock.new("Rock")
        @history.log_play(move)
        move    
    end 
end 

class RandomBot < Player
    def play
        move = $moves.sample
        @history.log_play(move)
        move
    end
end 

class IterativeBot < Player
    def initialize(name, history)
        super(name, history)
        @index = 0 #track the index 
    end 
    def play
        move = $moves[@index]
        @history.log_play(move)
        @index = (@index + 1) % $moves.size
        move
      end
end 

class LastPlayBot < Player
    def play
        # Play Rock on the first move if there is no previous opponent move
        move = if @history.opponent_plays.empty?
            Rock.new("Rock")
            else
                @history.opponent_plays.last  # Play the opponent's last move
            end
    
        @history.log_play(move)  # Log the chosen move to history
        move                     # Return the move
    end
end

class Human < Player
    def play
        move = nil
        loop do
            puts "(1) Rock\n(2) Paper\n(3) Scissors\n(4) Lizard\n(5) Spock"
            print "Enter your move: "
            input = gets.chomp
  
            case input
            when "1" then move = Rock.new("Rock")
            when "2" then move = Paper.new("Paper")
            when "3" then move = Scissors.new("Scissors")
            when "4" then move = Lizard.new("Lizard")
            when "5" then move = Spock.new("Spock")
            else
                puts "Invalid move - try again"
                next
            end
            break
        end
        @history.log_play(move) # Log the chosen move to history
        move 
    end
end 

