#!/usr/bin/julia
include("../../utils.jl")


input = partseToString(readInput("input.txt"))
parseRules = false
coords, rules = [], []
for line in input
    if line == ""
        global parseRules = true
        continue
    end
    if !parseRules
        x, y = map(x -> parse(Int, x), split(line, ','))
        push!(coords, (x + 1, y + 1))
    else
        axis, number = split(split(line, '=')[1], ' ')[3], split(line, '=')[2]
        push!(rules, (axis, parse(Int, number)+1))
    end
end

maxX, maxY = 0, 0
endCoords = copy(coords)
for (i, rule) in enumerate(rules)
    axis, foldLine = rule
    coordsAfterFold = []
    for coord in endCoords
        x, y = coord
        if axis == "y"
            if y > foldLine
                diffToFold = y - foldLine
                if (x, foldLine - diffToFold) ∉ coords
                    push!(coordsAfterFold, (x, foldLine - diffToFold))
                end
            else
                push!(coordsAfterFold, coord)
            end
        else
            if x > foldLine
                diffToFold = x - foldLine
                if (foldLine - diffToFold, y) ∉ coords
                    push!(coordsAfterFold, (foldLine - diffToFold, y))
                end
            else
                push!(coordsAfterFold, coord)
            end
        end
    end
    global endCoords = coordsAfterFold
    if axis == "y"
        global maxY = foldLine - 1
    else
        global maxX = foldLine - 1
    end
    if i == 1
        print("The answer to part 1 is: ", length(endCoords), '\n')
    end
end

print("The answer to part 2 is: ", "", '\n')
paper = fill('.', maxX, maxY)
for coord in endCoords
    paper[coord[1],coord[2]] = '#'
end
for col in eachcol(paper)
    println(col)
end
