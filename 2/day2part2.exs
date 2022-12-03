# TODO: Part 2
#
#


{:ok, contents} = File.read('input.txt')
win_hierarchy = [:rock, :scissors, :paper]
lose_hierarchy = Enum.reverse(win_hierarchy)
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
    [opponent[List.first(x)], outcome[List.last(x)]]
  end)

game_outcome_part2 = fn (op_move, req_outcome) ->
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

my_moves = games |>
  Enum.map(fn (x) ->
    game_outcome_part2.(List.first(x), List.last(x))
  end)

outcome_scored = games |>
  Enum.map(fn (x) ->
    game_scores[List.last(x)]
  end)

move_scored = my_moves |>
  Enum.map(fn (x) ->
    move_scores[x]
  end)


total_part2 = Enum.sum(outcome_scored ++ move_scored)
