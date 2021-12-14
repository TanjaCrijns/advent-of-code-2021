#!/usr/bin/julia
include("../../utils.jl")

input = partseToString(readInput("input.txt"))
hor, depth = 0, 0
for step in input
    instruction, amount = split(step, " ")[1], parse(Int64, split(step, " ")[2])
    if instruction == "forward"
        global hor += amount
    elseif instruction == "down"
        global depth += amount
    elseif instruction == "up"
        global depth -= amount
    end
end

println("The answer to part 1 is: ", hor * depth)

hor, depth, aim = 0, 0, 0
for step in input
    instruction, amount = split(step, " ")[1], parse(Int64, split(step, " ")[2])
    if instruction == "forward"
        global hor += amount
        if aim != 0
            global depth += aim*amount
        end
    elseif instruction == "down"
        global aim += amount
    elseif instruction == "up"
        global aim -= amount
    end
end

println("The answer to part 2 is: ", hor * depth)
