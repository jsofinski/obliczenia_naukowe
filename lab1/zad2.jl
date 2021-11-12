# autor: Jakub Sofiński
using Printf
using Statistics


function findMacheps(T)

    x::T = 3.0
    y::T = 4.0
    z::T = 3.0

    println(x * (y/z - 1) - 1)
end

println("\nFloat16")
findMacheps(Float16)
println(eps(Float16))

println("\nFloat16")
findMacheps(Float32)
println(eps(Float32))

println("\nFloat16")
findMacheps(Float64)
println(eps(Float64))

