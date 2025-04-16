class History
    attr_accessor :plays, :opponent_plays, :score

    #constructor that initializes plays, oponent plays and score
    def initialize
        @plays = Array.new
        @opponent_plays = Array.new
        @score = 0
    end

    # log the move made by the player
    def log_play(move)
        @plays.push(move)
    end 

    #log the move made by the opponent
    def log_opponent_play(move)
        @opponent_plays.push(move)
    end 

    #increase the score by 1
    def add_score()
        @score+=1
    end 

end 