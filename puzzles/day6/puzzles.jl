#!/usr/bin/julia
include("../../utils.jl")

function fishReproduce(fishCounts, days)
    for _ in 1:days
        newCounts = Dict(x => 0 for x in 0:8)
        for (key, value) in fishCounts
            key -= 1

            if key < 0
                newCounts[6] += value
                newCounts[8] += value
            else
                newCounts[key] += value
            end
        fishCounts = newCounts
        end
    end 
    return sum(values(fishCounts))
end


input = partseToInt(readInput("input.txt"), r",")
fishCounts = Dict(x => 0 for x in 0:8)
for fish in input
    fishCounts[fish] += 1
end

println("The answer to part 1 is: ", fishReproduce(fishCounts, 80))
println("The answer to part 2 is: ", fishReproduce(fishCounts, 256))