class WrongNumberOfPlayersError < StandardError; end
class NoSuchStrategyError < StandardError; end

def rps_game_winner(game)
  raise WrongNumberOfPlayersError unless game.length == 2

  player1, player2 = game
  p1_name, p1_move = player1
  p2_name, p2_move = player2
  
  p1_move.upcase!
  p2_move.upcase!

  valid_moves = %w[R P S]
  raise NoSuchStrategyError unless valid_moves.include?(p1_move) && valid_moves.include?(p2_move)

  return player1 if p1_move == p2_move

  wins_against = {
    'R' => 'S', 
    'S' => 'P', 
    'P' => 'R'  
  }

  if wins_against[p1_move] == p2_move
    player1
  else
    player2
  end
end

def rps_tournament_winner(tournament)
  left_side = tournament[0]

  if left_side[1].is_a?(String)
    return rps_game_winner(tournament)
  end

  winner_of_left_bracket = rps_tournament_winner(tournament[0])

  winner_of_right_bracket = rps_tournament_winner(tournament[1])

  rps_game_winner([winner_of_left_bracket, winner_of_right_bracket])
end

my_tournament = [
  [
    [['Kristen', 'P'], ['Dave', 'S']],
    [['Richard', 'R'], ['Michael', 'S']]
  ],
  [
    [['Allen', 'S'], ['Omer', 'P']],
    [['David E.', 'R'], ['Richard X.', 'P']]
  ]
]

begin
  winner = rps_tournament_winner(my_tournament)
  puts "The tournament winner is: #{winner[0]} with the move #{winner[1]}"
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end
