#!/usr/bin/julia
include("../../utils.jl")

function fishReproduce(fishCounts, days)
    for _ in 1:days
        newCounts = Dict()
        for (key, value) in fishCounts
            key -= 1

            if key < 0
                if 6 in keys(newCounts)
                    newCounts[6] += value
                else
                    newCounts[6] = value
                end
                
                if 8 in keys(newCounts)
                    newCounts[8] += value
                else
                    newCounts[8] = value
                end
            else
                if key in keys(newCounts)
                    newCounts[key] += value
                else
                    newCounts[key] = value
                end
            end
        fishCounts = newCounts
        end
    end 
    return sum(values(fishCounts))
end


input = partseToInt(readInput("input.txt"), r",")
fishCounts = Dict()
for fish in input
    if fish in keys(fishCounts)
        fishCounts[fish] += 1
    else
        fishCounts[fish] = 1
    end
end

print("The answer to part 1 is: ", fishReproduce(fishCounts, 80))
print("\nThe answer to part 2 is: ", fishReproduce(fishCounts, 256))