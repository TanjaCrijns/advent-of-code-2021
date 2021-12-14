#!/usr/bin/julia
include("../../utils.jl")

function getAllCoords(x1, y1, x2, y2, diagonal)
    if x1 == x2
        ycoords = min(y1,y2):max(y1,y2)
        return([(x1, y) for y in ycoords])
    elseif y1 == y2
        xcoords = min(x1,x2):max(x1,x2)
        return([(x, y1) for x in xcoords])
    end
    if diagonal 
        if x1 < x2 && y1 < y2
            dirX, dirY = 1,1
        elseif x1 < x2 && y1 > y2
            dirX, dirY = 1,-1
        elseif x1 > x2 && y1 < y2
            dirX, dirY = -1,1
        else
            dirX, dirY = -1,-1
        end

        coords = [(x1, y1)]
        for i in 1:abs(x1-x2)
            push!(coords, (x1+i*dirX, y1+i*dirY))
        end
        return(coords)
    end
    return([])
end

function fillVentDiagram(coords, diagonal)
    ventDiagram = zeros(Int, 1000,1000)
    overlap = 0
    for coord in coords
        allCoords = getAllCoords(coord[1], coord[2], coord[3], coord[4], diagonal)

        for ventPos in allCoords
            ventDiagram[ventPos[1],ventPos[2]] += 1
            if ventDiagram[ventPos[1],ventPos[2]] == 2
                overlap += 1
            end
        end
    end
    return overlap
end

input = partseToString(readInput("input.txt"))
coords = []
for (index, vent) in enumerate(input)
    firstCoord, secondCoord = split(vent, " -> ")
    x1, y1 = map(x -> parse(Int, x), split(firstCoord, ','))
    x2, y2 = map(x -> parse(Int, x), split(secondCoord, ','))
    push!(coords, (x1, y1, x2, y2))
end
println("The answer to part 1 is: ", fillVentDiagram(coords, false))
println("The answer to part 2 is: ", fillVentDiagram(coords, true))
