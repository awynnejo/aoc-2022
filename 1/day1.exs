# Advent of code day 1 part 1

{:ok, contents} = File.read('input.txt')

# Elf carrying most calories
contents
|> String.split("\n\n", trim: true)
|> Enum.map(fn (x) ->
  String.split(x, "\n", trim: true)
  |> Enum.map(&String.to_integer/1)
  |> Enum.sum
end)
|> Enum.max

# Total calories for top 3 elves
contents
|> String.split("\n\n", trim: true)
|> Enum.map(fn (x) ->
  String.split(x, "\n", trim: true)
  |> Enum.map(&String.to_integer/1)
  |> Enum.sum
end)
|> Enum.sort
|> Enum.take(-3)
|> Enum.sum
