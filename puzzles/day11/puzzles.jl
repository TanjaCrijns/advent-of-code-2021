#!/usr/bin/julia
include("../../utils.jl")

input = partseToString(readInput("input.txt"))

octopuses = zeros(Int, 10,10)
for i in 1:length(input)
    for j in 1:length(input)
        octopuses[i,j] = parse(Int,input[i][j])
    end
end

neighbors = [(-1,0), (0, -1), (1,0), (0,1), (-1,1), (-1,-1), (1,1), (1,-1)]
nFlashed, steps = 0, 0
allFlashed = false
while !allFlashed
    global steps += 1
    global octopuses = octopuses .+ 1
    toCheck = findall(a->a>9, octopuses)
    flashed = [] 
    while length(toCheck) > 0
        global nFlashed += 1
        x, y = toCheck[1][1], toCheck[1][2]
        octopuses[toCheck[1]] = 0
        push!(flashed, toCheck[1])
        for neighbor in neighbors
            if x + neighbor[1] >= 1 && x + neighbor[1] <= 10 && y + neighbor[2] >= 1 && y + neighbor[2] <= 10
                if CartesianIndex(x+neighbor[1], y+neighbor[2]) ∉ flashed && CartesianIndex(x+neighbor[1], y+neighbor[2]) ∉ toCheck 
                    if octopuses[x+neighbor[1], y+neighbor[2]] + 1 > 9
                        push!(toCheck, CartesianIndex(x+neighbor[1], y+neighbor[2]))
                    else
                        octopuses[x+neighbor[1], y+neighbor[2]] += 1
                    end
                end
            end  
        end
        toCheck = toCheck[2:end]
    end
    if steps == 100
        print("The answer to part 1 is: ", nFlashed, '\n')
    end
    if sum(octopuses) == 0
        print("The answer to part 2 is: ", steps, '\n')
        global allFlashed = true
    end
end