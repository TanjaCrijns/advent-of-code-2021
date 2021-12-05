#!/usr/bin/julia
include("../../utils.jl")


input = partseToString(readInput("input.txt"))

print("The answer to part 1 is: ", firstWinningScores[winningIndicesOrder[1]])
print("\nThe answer to part 2 is: ", firstWinningScores[winningIndicesOrder[end]])
