require_relative "element"   # uncomment to load element.rb
require_relative "player"    # uncomment to load player.rb 
require_relative "history"   # uncomment to load history.rb

######################################### 	
#     CS 381 - Programming Lab #3		#
#										#
#  Ishanshi Bhardwaj					#
#  bhardwai@oregonstate.edu				#
#										#
#########################################

# Display the welcome message and options for selecting players
def display_welcome
  puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  puts "\nPlease choose two players:"
  puts "(1) StupidBot"
  puts "(2) RandomBot"
  puts "(3) IterativeBot"
  puts "(4) LastPlayBot"
  puts "(5) Human"
end

# Prompt user to select two players and return them
def select_players
  loop do
    print "Select player 1: "
    player1 = create_player(gets.chomp)

    print "Select player 2: "
    player2 = create_player(gets.chomp)

    # Ensure both player selections are valid
    return player1, player2 if player1 && player2
    
    puts "Invalid choice(s) - start over"
  end
end

# Create player instances based on input
def create_player(choice)
  case choice
  when "1"
    StupidBot.new("StupidBot", History.new)
  when "2"
    RandomBot.new("RandomBot", History.new)
  when "3"
    IterativeBot.new("IterativeBot", History.new)
  when "4"
    LastPlayBot.new("LastPlayBot", History.new)
  when "5"
    Human.new("Human", History.new)
  else
    nil
  end
end

# Play a round and return the result
def play_single_round(player1, player2, round_number)
  puts "\nRound #{round_number}:"
  move1 = player1.play
  move2 = player2.play

  puts "Player 1 chose #{move1.name}"
  puts "Player 2 chose #{move2.name}"

  # If the round is a tie
  if move1.name == move2.name
    puts "#{move1.name} equals #{move2.name}"
    puts "Round was a tie"
    player1.history.log_opponent_play(move2)
    player2.history.log_opponent_play(move1)
    return "Tie"
  end

  # Compare moves and determine the winner
  result, outcome = move1.compare_to(move2)
  puts result

  if outcome == "Win"
    player1.history.add_score
    puts "Player 1 won the round"
    player1.history.log_opponent_play(move2)
    player2.history.log_opponent_play(move1)
    return player1.name
  else
    player2.history.add_score
    puts "Player 2 won the round"
    player1.history.log_opponent_play(move2)
    player2.history.log_opponent_play(move1)
    return player2.name
  end
end

# Main function to manage game flow for a number of rounds
def game(rounds)
  display_welcome
  player1, player2 = select_players

  puts "#{player1.name} vs. #{player2.name}\n"

  # Play the specified number of rounds
  rounds.times do |round|
    play_single_round(player1, player2, round + 1)
  end

  # Show final score and determine the winner
  puts "\nFinal score is #{player1.history.score} to #{player2.history.score}"

  if player1.history.score > player2.history.score
    puts "Player 1 wins the game!"
  elsif player2.history.score > player1.history.score
    puts "Player 2 wins the game!"
  else
    puts "Game was a draw"
  end
end


# Main Program (should be last)
n_rounds = 5
game(n_rounds)
