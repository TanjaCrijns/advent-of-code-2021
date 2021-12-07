#!/usr/bin/julia
include("../../utils.jl")


input = partseToInt(readInput("input.txt"), r",")

leastConstant = 1000000000000000000000
leastIncrease = 1000000000000000000000
for pos in 0:length(input)-1
    distancesConstant = []
    distancesIncrease = []
    for crab in input
        dist = abs(crab-pos)
        push!(distancesConstant, dist)
        push!(distancesIncrease, sum(1:dist))
    end
    if sum(distancesConstant) < leastConstant
        global leastConstant = sum(distancesConstant)
    end
    if sum(distancesIncrease) < leastIncrease
        global leastIncrease = sum(distancesIncrease)
    end
end


print("The answer to part 1 is: ", leastConstant)
print("\nThe answer to part 2 is: ", leastIncrease)