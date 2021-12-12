#!/usr/bin/julia
include("../../utils.jl")


input = partseToString(readInput("input.txt"))
connections = Dict()
for connection in input
    node1, node2 = split(connection, "-")[1], split(connection, "-")[2]
    if node1 in keys(connections)
        connections[node1] = push!(connections[node1], node2)
    else
        connections[node1] = [node2]
    end

    if node2 in keys(connections)
        connections[node2] = push!(connections[node2], node1)
    else
        connections[node2] = [node1]
    end
end

### Part 1 ###

endRoutes = []
currentRoutes = [["start"]]
while length(currentRoutes) > 0
    currentRoute = currentRoutes[1]
    for connection in connections[currentRoute[end]]
        tempRoute = deepcopy(currentRoute)
        if connection == "end"
            push!(tempRoute, connection)
            push!(endRoutes, tempRoute)
        elseif connection == lowercase(connection)
            if connection ∉ tempRoute
                push!(tempRoute, connection)
                push!(currentRoutes, tempRoute)
            end
        else
            push!(tempRoute, connection)
            push!(currentRoutes, tempRoute)
        end
    end
    global currentRoutes = currentRoutes[2:end]
end


print("The answer to part 1 is: ", length(endRoutes), '\n')

### Part 2 ###

function firstDuplicate(route)
    lowerRoute = [x for x in route if lowercase(x) == x]
    if length(Set(lowerRoute)) == length(lowerRoute)
        return true
    end
    return false
end

endRoutes = []
currentRoutes = [["start"]]
while length(currentRoutes) > 0
    currentRoute = currentRoutes[1]
    for connection in connections[currentRoute[end]]
        tempRoute = deepcopy(currentRoute)
        if connection == "end"
            push!(tempRoute, connection)
            push!(endRoutes, tempRoute)
        elseif connection == lowercase(connection)
            if connection != "start" && (connection ∉ tempRoute || firstDuplicate(tempRoute))
                push!(tempRoute, connection)
                push!(currentRoutes, tempRoute)
            end
        else
            push!(tempRoute, connection)
            push!(currentRoutes, tempRoute)
        end
    end
    global currentRoutes = currentRoutes[2:end]
end

print("The answer to part 2 is: ", length(endRoutes), '\n')