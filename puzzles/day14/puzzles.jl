#!/usr/bin/julia
include("../../utils.jl")

function runPolymer(steps, template, letters, rules)
    template, letters = copy(template), copy(letters)
    for _ in 1:steps
        tempTemplate = Dict()
        for pair in keys(template)
            if pair in keys(rules)
                newletter = rules[pair]
                pairA, pairB = join([pair[1], newletter]), join([newletter, pair[2]])
                tempTemplate[pairA] = get(tempTemplate, pairA, 0) + template[pair]
                tempTemplate[pairB] = get(tempTemplate, pairB, 0) + template[pair]
                letters[newletter] = get(letters, newletter, 0) + template[pair]
            else
                tempTemplate[pair] = get(tempTemplate, pair, 0) + template[pair]
            end
        end
        template = copy(tempTemplate)
    end
    return maximum(values(letters)) - minimum(values(letters))
end

input = partseToString(readInput("input.txt"))
template, letters = Dict(), Dict()
for letterIndex in 1:length(input[1])
    letters[input[1][letterIndex]] = get(letters, input[1][letterIndex], 0) + 1
    if letterIndex < length(input[1])
        letterA, letterB = input[1][letterIndex], input[1][letterIndex+1]
        pair = join([letterA, letterB])
        template[pair] = get(template, pair, 0) + 1
    end
end
rules = Dict(split(line, " -> ")[1] => only(split(line, " -> ")[2]) for line in input[3:end])

println("The answer to part 1 is: ", runPolymer(10, template, letters, rules))
println("The answer to part 2 is: ", runPolymer(40, template, letters, rules))
