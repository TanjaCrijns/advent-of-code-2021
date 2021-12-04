#!/usr/bin/julia
include("../../utils.jl")


input = partseToString(readInput("input.txt"))
drawNumbers = [parse(Int, x) for x in split(input[1], ',')]
cards = []
tempCard = Array{Int}[] 
for cardRow in input[3:end]
    if length(cardRow) < 1
        push!(cards, tempCard)
        global tempCard = Array{Int}[] 
    else
        push!(tempCard, [parse(Int, x) for x in split(cardRow) if x != ' '])
    end
end

function checkWin(card)
    for i in 1:5
        columnCount = 0
        for j in 1:5
            columnCount += card[j][i]
        end
        if columnCount == -5 || sum(card[i]) == -5
            return true
        end
    end
    return false
end

function finalScore(card, number)
    return number * sum([x for x in [(card...)...] if x != -1])
end
        

function playGame()
    winningIndicesOrder = []
    firstWinningScores = Dict{Int, Int}()
    for number in drawNumbers
        for (index, card) in enumerate(cards)
            for (indexCard, row) in enumerate(card)
                for (indexNumber, cardNumber) in enumerate(row)
                    if number == cardNumber
                        cards[index][indexCard][indexNumber] = -1
                    end
                end
            end
            if checkWin(card)
                if index ∉ winningIndicesOrder 
                    append!(winningIndicesOrder, index)
                    firstWinningScores[index] = finalScore(card, number)
                end
            end
        end
    end
    return winningIndicesOrder, firstWinningScores
end

winningIndicesOrder, firstWinningScores = playGame()
print("The answer to part 1 is: ", firstWinningScores[winningIndicesOrder[1]])
print("\nThe answer to part 2 is: ", firstWinningScores[winningIndicesOrder[end]])
