#!/usr/bin/julia
include("../../utils.jl")

input = listOfStringsToInt(readInput("input.txt"))
print("The answer to part 1 is: ", count(x->x>0, diff(input)))

sums = Vector{Int}()
for (index, value) in enumerate(input[1:end-2])
    append!(sums, (value+input[index+1]+input[index+2]))
end

print("\nThe answer to part 2 is: ", count(x->x>0, diff(sums)))
