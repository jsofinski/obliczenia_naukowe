# autor: Jakub Sofiński
using Printf
using Statistics



function f(x::Float64)
    return Float64(sqrt(x^2 + 1.0) - 1.0)
end


function g(x::Float64)
    return Float64(x^2/(sqrt(x^2 + 1.0) + 1.0))
end

for i = 1:10
    value = Float64(8)^(-(i))
    println("f(8^-$i):\t$(f(value))")
    println("g(8^-$i):\t$(g(value))")
    println()
end


i = 50
value = Float64(8)^(-(i))
println("f(8^-$i):\t$(f(value))")
println("g(8^-$i):\t$(g(value))")