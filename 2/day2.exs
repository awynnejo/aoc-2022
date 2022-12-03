# Advent of code day 2
# https://adventofcode.com/2022/day/2
#

{:ok, contents} = File.read('input.txt')

hierarchy = [:rock, :scissors, :paper]
move_scores = %{rock: 1, paper: 2, scissors: 3}
game_scores = %{loss: 0, draw: 3, win: 6}
opponent = %{"A" => :rock, "B" => :paper, "C" => :scissors}
me = %{"X" => :rock, "Y" => :paper, "Z" => :scissors}
outcome = %{"X" => :loss, "Y" => :draw, "Z" => :win}

games = contents |>
  String.split("\n", trim: true) |>
  Enum.map(fn (x) ->
    String.split(x, " ")
  end) |>
  Enum.map(fn (x) ->
    [opponent[List.first(x)], me[List.last(x)]]
  end)

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

game_outcome_part2 = fn (op_move, req_outcome) ->
  if (req_outcome == :draw) do
    op_move
  else
    op_move_hierarchy = Enum.find_index(hierarchy, fn x -> x == op_move end)
    {:ok, my_winning_move} = Enum.fetch(hierarchy, op_move_hierarchy-1)
    {:ok, my_losing_move} = Enum.fetch(hierarchy, rem(op_move_hierarchy+1, 2))
    if (req_outcome == :win) do
      my_winning_move
    else
      my_losing_move
    end
  end
end

outcomes = games |>
  Enum.map(fn (x) ->
    game_outcome.(List.first(x), List.last(x))
  end)

outcome_scored = outcomes |>
  Enum.map(fn (x) ->
    game_scores[x]
  end)

move_scored = games |>
  Enum.map(fn (x) ->
    move_scores[List.last(x)]
  end)


# Part 1 answer
total = Enum.sum(outcome_scored ++ move_scored)

# TODO: Part 2
