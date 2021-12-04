#!/usr/bin/julia
include("../../utils.jl")

input = partseToString(readInput("input.txt"))

input = partseToString(readInput("input.txt"))
report = transpose(hcat([[parse(Int, x) for x in bitRow] for bitRow in input]...))

gamma, epsilon = "", ""
for i in 1:length(input[1])
    if sum(report[:,i]) > (length(input)/2)
        global gamma *= '1'
        global epsilon *= '0'
    else 
        global gamma *= '0'
        global epsilon *= '1'
    end
end

print("The answer to part 1 is: ", parse(Int, gamma; base=2) * parse(Int, epsilon; base=2))

oxygenGenerator, co2Scrubber= "", ""
oxyReport, co2Report = deepcopy(report), deepcopy(report)
oxyTemp, co2Temp = [], []
for i in 1:length(input[1])
    if sum(oxyReport[:,i]) >= (size(oxyReport)[1]/2)
        for row in eachrow(oxyReport)
            if row[i] == 1
                push!(oxyTemp, row)
            end
        end
    else 
        for row in eachrow(oxyReport)
            if row[i] == 0
                push!(oxyTemp, row)
            end
        end
    end
    if length(oxyTemp) == 1
        global oxygenGenerator = join(oxyTemp[1])
        break
    end
    global oxyReport = (transpose(hcat(oxyTemp...)))
    global oxyTemp = []
end

for i in 1:length(input[1])
    if sum(co2Report[:,i]) >= (size(co2Report)[1]/2)
        for row in eachrow(co2Report)
            if row[i] == 0
                push!(co2Temp, row)
            end
        end
    else 
        for row in eachrow(co2Report)
            if row[i] == 1
                push!(co2Temp, row)
            end
        end
    end
    if length(co2Temp) == 1
        global co2Scrubber = join(co2Temp[1])
        break
    end
    global co2Report = (transpose(hcat(co2Temp...)))
    global co2Temp = []
end

print("\nThe answer to part 2 is: ", parse(Int, oxygenGenerator; base=2) * parse(Int, co2Scrubber; base=2))
