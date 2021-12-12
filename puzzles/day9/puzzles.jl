#!/usr/bin/julia
include("../../utils.jl")

function checkAdjacentLocations(x,y,heightMap)
    neighbors = [(-1,0), (0, -1), (1,0), (0,1)]
    higherNeighbors = 0
    for neighbor in neighbors
        if x + neighbor[1] < 1 || x + neighbor[1] > 100 || y + neighbor[2] < 1 || y + neighbor[2] > 100
            higherNeighbors += 1
        else
            if heightMap[x+neighbor[1], y+neighbor[2]] > heightMap[x,y]
                higherNeighbors += 1
            end
        end
    end
    return (higherNeighbors==4, heightMap[x,y]+1)
end

function getBasinSize(x,y,heightMap)
    toCheck = [(x,y)]
    found = []
    neighbors = [(-1,0), (0, -1), (1,0), (0,1)]

    while length(toCheck) > 0
        for neighbor in neighbors
            tempX, tempY = toCheck[1][1], toCheck[1][2]
            if tempX + neighbor[1] < 1 || tempX + neighbor[1] > 100 || tempY + neighbor[2] < 1 || tempY + neighbor[2] > 100
            else
                if heightMap[tempX+neighbor[1], tempY+neighbor[2]] != 9
                    if (tempX+neighbor[1], tempY+neighbor[2]) ∉ found
                        push!(found, (tempX+neighbor[1], tempY+neighbor[2]))
                        push!(toCheck, (tempX+neighbor[1], tempY+neighbor[2]))
                    end
                end
            end
        end
        popfirst!(toCheck)
    end
    return length(found)
end

### Create heightmap matrix ###
input = partseToString(readInput("input.txt"))
heightMap = zeros(Int, 100,100)
for i in 1:length(input)
    for j in 1:length(input)
        heightMap[i,j] = parse(Int,input[i][j])
    end
end

### Find lowpoints ###
risks = []
lowPoints = []
for i in 1:length(input)
    for j in 1:length(input)
        lowPoint, risklevel = checkAdjacentLocations(i,j,heightMap)
        if lowPoint
            push!(risks, risklevel)
            push!(lowPoints, (i,j))
        end
    end
end

### Calculate basins ###
basinSizes = []
for lowPoint in lowPoints
    push!(basinSizes, getBasinSize(lowPoint[1], lowPoint[2], heightMap))
end

print("The answer to part 1 is: ", sum(risks), '\n')
print("The answer to part 2 is: ", reduce(*, sort(basinSizes)[end-2:end]), '\n')
