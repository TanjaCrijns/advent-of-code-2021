#!/usr/bin/julia

function readInput(path::String)
    input = open(path, "r") do file
        read(file, String)
    end
    return input
end