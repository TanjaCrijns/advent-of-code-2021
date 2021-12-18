#!/usr/bin/julia
include("../../utils.jl")

function legalShot(velX, velY, xLow, xHigh, yLow, yHigh)
    notFinished = true
    locX, locY = 0, 0
    while notFinished
        locX = locX + velX
        locY = locY + velY
        velX = maximum([0, velX - 1])
        velY -= 1
        
        if locX >= xLow && locX <= xHigh && locY >= yLow && locY <= yHigh
            return true
        end
        if locX > xHigh || locY < yLow
            return false
        end
    end
end

xLow, xHigh, yLow, yHigh = 94, 151, -156, -103

highestY, highestPos = 0, 0
for x in 0:xHigh
    for y in yLow:1000
        if legalShot(x,y, xLow, xHigh, yLow, yHigh)
            if y > highestY
                global highestY = y
                global highestPos = sum(0:y)
            end
        end
    end
end
println("The answer to part 1 is: ", highestPos)

nLegalShots = 0
for x in 0:xHigh
    for y in yLow:1000
        if legalShot(x,y, xLow, xHigh, yLow, yHigh)
            global nLegalShots += 1
        end
    end
end
println("The answer to part 2 is: ", nLegalShots)
