#!/usr/bin/julia

function readInput(path::String)
    input = open(path, "r") do file
        read(file, String)
    end
    return input
end

function partseToInt(input::String, delim::Regex)
    return parse.(Int, split(input, delim))
end

function partseToString(input::String)
    return split(input, r"\n|\r\n")
end