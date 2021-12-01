#!/usr/bin/julia

function readInput(path::String)
    input = open(path, "r") do file
        read(file, String)
    end
    return input
end

function listOfStringsToInt(input::String)
    return parse.(Int, split(input))
end