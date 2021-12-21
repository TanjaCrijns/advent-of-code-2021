#!/usr/bin/julia

p1Start, p2Start = 2, 8


positions = [p1Start, p2Start]
diceValue = 1
diceThrows = 0
scores = [0, 0]
playerWin = false
while !playerWin
    for player in 1:2
        nextPos = (positions[player] + diceValue * 3 + 2) % 10 + 1
        global diceValue = diceValue + 3 % 100
        global diceThrows += 3
        scores[player] += nextPos
        positions[player] = nextPos
        if scores[player] >= 1000
			global puzzle1 = scores[3-player]*(diceThrows)
            global playerWin = true
            break
        end
    end
end

println("The answer to part 1 is: ", puzzle1)

outcomes = [sum([x,y,z]) for x in 1:3 for y in 1:3 for z in 1:3]
universes = Dict((p1Start, p2Start, 0, 0) => 1)

wins = [0,0]
player = 1
while length(universes) > 0
    newUniverses = Dict()
    for (universe, count) in universes
        for outcome in outcomes
            nextPos = (universe[player] + outcome) % 10
            if nextPos == 0
                nextPos = 10
            end
            nextScore = universe[player+2] + nextPos
            if nextScore >= 21
                wins[player] += count
            else
                if player == 1
                    nextUniverse = (nextPos, universe[2], nextScore, universe[4])
                else
                    nextUniverse = (universe[1], nextPos, universe[3], nextScore)
                end
                newUniverses[nextUniverse] = get(newUniverses, nextUniverse, 0) + count
            end
        end
    end
    if player == 1
        global player = 2
    else
        global player = 1
    end
    global universes = newUniverses
end
println("The answer to part 2 is: ", maximum(wins))