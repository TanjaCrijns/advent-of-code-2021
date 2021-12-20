#!/usr/bin/julia
include("../../utils.jl")

input = partseToString(readInput("input.txt"))
enhancementAlg, inputImage = input[1], input[3:end]

lightPixels = Set()
minX, minY, maxX, maxY = 1000000, 1000000, 0, 0
for (y, row) in enumerate(inputImage)
    y -= 1
    for (x, pixel) in enumerate(row)
        x -= 1
        if pixel == '#'
            push!(lightPixels, (x,y))
            global minX = minimum([minX, x])
            global minY = minimum([minY, y])
            global maxX = maximum([maxX, x])
            global maxY = maximum([maxY, y])
        end
    end
end

function printImage(lightPixels, minX, minY, maxX, maxY)
    for x in minX:maxX
        for y in minY:maxY
            if (y,x) ∈ lightPixels
                print('#')
            else
                print('.')
            end
        end
        print("\n")
    end
    print("\n")
end

function enhance(n, enhancementAlg, lightPixels, minX, minY, maxX, maxY)
    neighbors = [(-1,-1), (0,-1), (1,-1), (-1,0), (0,0), (1,0), (-1,1), (0,1), (1,1)]
    lightPixels, minX, minY, maxX, maxY = copy(lightPixels), copy(minX), copy(minY), copy(maxX), copy(maxY)
    # printImage(lightPixels, minX, minY, maxX, maxY)
    outer = "0"
    for _ in 1:n
        minX -= 1
        minY -= 1
        maxX += 1
        maxY += 1
        tempPixels = copy(lightPixels)
        for x in minX:maxX+1
            for y in minY:maxY+1
                toCheck = ""
                for neighbor in neighbors
                    xToCheck, yToCheck = x+neighbor[1], y+neighbor[2]
                    if xToCheck <= minX || xToCheck >= maxX || yToCheck <= minY || yToCheck >= maxY
                        toCheck *= outer
                    elseif (xToCheck, yToCheck) ∈ lightPixels
                        toCheck *= "1"
                    else
                        toCheck *= "0"
                    end
                end
                binNumber = parse(Int, toCheck; base=2) + 1
                if enhancementAlg[binNumber] == '#'
                    push!(tempPixels, (x,y))
                else
                    if (x,y) ∈ tempPixels
                        delete!(tempPixels, (x,y))
                    end
                end
            end
        end
        binaryNumber = parse(Int, repeat(outer, 9); base=2) + 1
        if enhancementAlg[binaryNumber] == '.'
            outer = "0"
        else
            outer = "1"
        end
        lightPixels = tempPixels
    end
    return length(lightPixels)
end

println("The answer to part 1 is: ", enhance(2, enhancementAlg, lightPixels, minX, minY, maxX, maxY))
println("The answer to part 2 is: ", enhance(50, enhancementAlg, lightPixels, minX, minY, maxX, maxY))
