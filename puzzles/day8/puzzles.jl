#!/usr/bin/julia
include("../../utils.jl")


input = partseToString(readInput("input.txt"))

### Part 1 ###
count = Dict(x => 0 for x in 2:7)
for line in input
    output_digits = split(split(line, " | ")[2], ' ')
    for digit in output_digits
        global count[length(digit)] += 1
    end
end

### Part 2 ###

function similarity(pattern1, pattern2)
    nSimilar = 0
    for letter in pattern1
        if letter in pattern2
            nSimilar +=1
        end
    end
    return nSimilar 
end


total = 0
for line in input
    input_patterns = split(split(line, " | ")[1], ' ')
    output_patterns = split(split(line, " | ")[2], ' ')
    numbers = Dict(x => "" for x in 0:9)
    numbers[1] = [pattern for pattern in input_patterns if length(pattern) == 2][1]
    numbers[4] = [pattern for pattern in input_patterns if length(pattern) == 4][1]
    numbers[7] = [pattern for pattern in input_patterns if length(pattern) == 3][1]
    numbers[8] = [pattern for pattern in input_patterns if length(pattern) == 7][1]
    numbers[6] = [pattern for pattern in input_patterns if length(pattern) == 6 && similarity(pattern, numbers[7]) == 2][1]
    numbers[3] = [pattern for pattern in input_patterns if length(pattern) == 5 && similarity(pattern, numbers[7]) == 3][1]
    numbers[9] = [pattern for pattern in input_patterns if length(pattern) == 6 && similarity(pattern, numbers[4]) == 4][1]
    numbers[5] = [pattern for pattern in input_patterns if length(pattern) == 5 && similarity(pattern, numbers[7]) == 2 && similarity(pattern, numbers[4]) == 3][1]
    numbers[0] = [pattern for pattern in input_patterns if length(pattern) == 6 && similarity(pattern, numbers[7]) == 3 && similarity(pattern, numbers[4]) == 3][1]
    numbers[2] = [pattern for pattern in input_patterns if length(pattern) == 5 && similarity(pattern, numbers[7]) == 2 && similarity(pattern, numbers[4]) == 2][1]

    sortedNums = Dict(join(sort(split(value,""))) => string(key) for (key, value) in numbers)
    sortedOutput = [join(sort(split(x,""))) for x in output_patterns]
    tempTotal = join([sortedNums[num] for num in sortedOutput])
    global total += parse(Int, tempTotal)
end

print("\nThe answer to part 1 is: ", count[2] + count[3] + count[4] + count[7])
print("\nThe answer to part 2 is: ", total)

