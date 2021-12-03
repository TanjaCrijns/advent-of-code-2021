#!/usr/bin/julia
include("../../utils.jl")

input = partseToString(readInput("input.txt"))
print(length(input))
common = Dict( i => 0 for i in 1:length(input[1]))
for number in input
    for (index, single) in enumerate(number)
        if single == '1'
            global common[index] += 1
        end
    end
end
print(common)

gamma, epsilon = "", ""
for i in 1:length(input[1])
    if common[i] > (length(input)/2)
        global gamma *= '1'
        global epsilon *= '0'
    else 
        global gamma *= '0'
        global epsilon *= '1'
    end
end

print("The answer to part 1 is: ", parse(Int, gamma; base=2) * parse(Int, epsilon; base=2))


# print("\nThe answer to part 2 is: ", hor * depth)
