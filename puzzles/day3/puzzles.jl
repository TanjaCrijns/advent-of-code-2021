#!/usr/bin/julia
include("../../utils.jl")

input = partseToString(readInput("input.txt"))

input = partseToString(readInput("input.txt"))
report = hcat([[parse(Int, x) for x in bitRow] for bitRow in input]...)

gamma, epsilon = "", ""
for i in 1:length(input[1])
    if sum(report[i,:]) > (length(input)/2)
        global gamma *= '1'
        global epsilon *= '0'
    else 
        global gamma *= '0'
        global epsilon *= '1'
    end
end

print("The answer to part 1 is: ", parse(Int, gamma; base=2) * parse(Int, epsilon; base=2))

# oxygenGeneratorOxy, oxygenGeneratorCo2 = "", ""
# maxLenOxy, maxLenCo2 = 0, 0


# print("\nThe answer to part 2 is: ", parse(Int, oxygenGeneratorCo2; base=2) * parse(Int, oxygenGeneratorOxy; base=2))
