# Day 2 Part 1
# https://adventofcode.com/2022/day/2
#

# Read input
{:ok, contents} = File.read('input.txt')

hierarchy = [:rock, :scissors, :paper] # winning moves left to right
move_scores = %{rock: 1, paper: 2, scissors: 3}
game_scores = %{loss: 0, draw: 3, win: 6}
opponent = %{"A" => :rock, "B" => :paper, "C" => :scissors}
me = %{"X" => :rock, "Y" => :paper, "Z" => :scissors}
outcome = %{"X" => :loss, "Y" => :draw, "Z" => :win}


# Convert input code to my move and opponent move
games = contents |>
  String.split("\n", trim: true) |>
  Enum.map(fn (x) ->
    String.split(x, " ")
  end) |>
  Enum.map(fn (x) ->
    [opponent[List.first(x)], me[List.last(x)]]
  end)

# Function that takes opponent move and my move, and returns game outcome for me (win/loss/draw)
game_outcome = fn (op_move, my_move) ->
  if (op_move == my_move) do
    :draw
  else
    op_move_hierarchy = Enum.find_index(hierarchy, fn x -> x == op_move end)
    {:ok, my_winning_move} = Enum.fetch(hierarchy, op_move_hierarchy-1)
    if (my_winning_move == my_move) do
      :win
    else
      :loss
    end
  end
end

# Determine game outcomes
outcomes = games |>
  Enum.map(fn (x) ->
    game_outcome.(List.first(x), List.last(x))
  end)
# Score game outcomes
outcome_scored = outcomes |>
  Enum.map(fn (x) ->
    game_scores[x]
  end)
# Score my moves
move_scored = games |>
  Enum.map(fn (x) ->
    move_scores[List.last(x)]
  end)


# Part 1 answer
total = Enum.sum(outcome_scored ++ move_scored)
