# Advent of code day 3
# https://adventofcode.com/2022/day/3
# Part 1

{:ok, contents} = File.read('input.txt')

lowerupper = (for n <- ?a..?z, do: <<n :: utf8>>) ++ (for n <- ?A..?Z, do: << n :: utf8>>)

contents
|> String.split("\n", trim: true)
|> Enum.map(fn (x) ->
  length = String.length(x)
  half_length = div(length,2)
  [String.slice(x, 0..half_length-1),
   String.slice(x, half_length..length)
  ]
end)
|> Enum.map(fn (x) ->
  String.myers_difference(List.first(x),List.last(x))[:eq]
end)
|> Enum.map(fn (char) ->
  Enum.find_index(lowerupper, fn (x) -> x == char end) + 1
end)
|> Enum.sum()

# Part 2
