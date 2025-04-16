
# Abstract subplacc Element 
class Element
    attr_accessor :name

    def initialize(name)
        @name = name
    end
    
    def compare_to(other)
        fail "This method should be overridden" 
    end
end

# Subclass of Rock
class Rock < Element
    def compare_to(other)
        case other.name
        when "Scissors"
            ["Rock crushes Scissors", "Win"]
        when "Paper"
            ["Paper covers Rock", "Lose"]
        when "Rock"
            ["Rock equals Rock", "Tie"]
        when "Lizard"
            ["Rock crushes Lizard", "Win"]
        when "Spock"
            ["Spock vaporizes Rock", "Lose"]
        end
    end
end  

# Subclass of Paper
class Paper < Element
    def compare_to(other)
        case other.name
        when "Scissors"
            ["Scissors cut Paper", "Lose"]
        when "Paper"
            ["Paper equal Paper", "Tie"]
        when "Rock"
            ["Paper covers Rock", "Win"]
        when "Lizard"
            ["Lizard eats Paper", "Lose"]
        when "Spock"
            ["Paper disproves Spock", "Win"]
        end
    end
end  

# Subclass of Scissors
class Scissors < Element
    def compare_to(other)
        case other.name
        when "Scissors"
            ["Scissors equals Scissors", "Tie"]
        when "Paper"
            ["Scissors cut Paper", "Win"]
        when "Rock"
            ["Rock crushes Scissors", "Lose"]
        when "Lizard"
            ["Scissors decapitate Lizard", "Win"]
        when "Spock"
            ["Spock smashes Scissors", "Lose"]
        end
    end
end  

# Subclass of Lizard
class Lizard < Element
    def compare_to(other)
        case other.name
        when "Scissors"
            ["Scissors decapitate Lizard", "Lose"]
        when "Paper"
            ["Lizard eats Paper", "Win"]
        when "Rock"
            ["Rock crushes Lizard", "Lose"]
        when "Lizard"
            ["Lizard equal Lizard", "Tie"]
        when "Spock"
            ["Lizard poisons Spock", "Win"]
        end
    end
end  

# Subclass of Spock
class Spock < Element
    def compare_to(other)
        case other.name
        when "Scissors"
            ["Spock smashes Scissors", "Win"]
        when "Paper"
            ["Paper disproves Spock", "Lose"]
        when "Rock"
            ["Spock vaporizes Rock", "Win"]
        when "Lizard"
            ["Lizard poisons Spock", "Lose"]
        when "Spock"
            ["Spock equal Spock", "Tie"]
        end
    end
end  


#global list of moves 
$moves= [
    Rock.new("Rock"),
    Paper.new("Paper"),
    Scissors.new("Scissors"),
    Lizard.new("Lizard"),
    Spock.new("Spock")
]
