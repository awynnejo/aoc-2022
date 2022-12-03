# Day 2 Part 2
# https://adventofcode.com/2022/day/2
#

# Read input
{:ok, contents} = File.read('input.txt')

win_hierarchy = [:rock, :scissors, :paper] # winning moves left to right
lose_hierarchy = Enum.reverse(win_hierarchy) # losing moves left to right
move_scores = %{rock: 1, paper: 2, scissors: 3}
game_scores = %{loss: 0, draw: 3, win: 6}
opponent = %{"A" => :rock, "B" => :paper, "C" => :scissors}
outcome = %{"X" => :loss, "Y" => :draw, "Z" => :win}

# Convert input code to opponent move and required outcome
games = contents |>
  String.split("\n", trim: true) |>
  Enum.map(fn (x) ->
    String.split(x, " ")
  end) |>
  Enum.map(fn (x) ->
    [opponent[List.first(x)], outcome[List.last(x)]]
  end)
# Function that takes opponent move (paper/scissors/rock) and required outcome (win/loss/draw), and returns my required move
# e.g. iex>my_required_move.(:scissors, :win)
# :rock
my_required_move = fn (op_move, req_outcome) ->
  if (req_outcome == :draw) do
    op_move
  else
    op_move_win_hierarchy = Enum.find_index(win_hierarchy, fn x -> x == op_move end)
    op_move_lose_hierarchy = Enum.find_index(lose_hierarchy, fn x -> x == op_move end)
    {:ok, my_winning_move} = Enum.fetch(win_hierarchy, op_move_win_hierarchy-1)
    {:ok, my_losing_move} = Enum.fetch(lose_hierarchy, op_move_lose_hierarchy-1)
    if (req_outcome == :win) do
      my_winning_move
    else
      my_losing_move
    end
  end
end

# Determine moves I need to make
my_moves = games |>
  Enum.map(fn (x) ->
    my_required_move.(List.first(x), List.last(x))
  end)
# Score the outcomes
outcome_scored = games |>
  Enum.map(fn (x) ->
    game_scores[List.last(x)]
  end)
# Score the moves
move_scored = my_moves |>
  Enum.map(fn (x) ->
    move_scores[x]
  end)

# Sum
total_part2 = Enum.sum(outcome_scored ++ move_scored)
