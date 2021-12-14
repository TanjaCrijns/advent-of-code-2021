#!/usr/bin/julia
include("../../utils.jl")


input = partseToString(readInput("input.txt"))

pairs = Dict('(' => ')', '[' => ']', '{' => '}', '<' => '>')
illegals = []
incompletedLines = []
for line in input
    incomplete = true
    openers = []
    for character in line
        if character in keys(pairs)
            push!(openers, character)
        else
            if pairs[pop!(openers)] != character
                incomplete = false
                push!(illegals, character)
                break
            end
        end
    end
    if incomplete
        push!(incompletedLines, openers)
    end
end

illegalScoreTable = Dict(')' => 3, ']' => 57, '}' => 1197, '>' => 25137)
syntaxErrorCode = sum([illegalScoreTable[character] for character in illegals])

completionScoreTable = Dict(')' => 1, ']' => 2, '}' => 3, '>' => 4)
completionScores = []
for line in incompletedLines
    completionScore = 0
    completionString = [pairs[character] for character in reverse(line)]
    for character in completionString
        completionScore = completionScore * 5 + completionScoreTable[character]
    end
    push!(completionScores, completionScore)
end

println("The answer to part 1 is: ", syntaxErrorCode)
println("The answer to part 2 is: ", sort(completionScores)[Int(round(length(completionScores)/2))])
