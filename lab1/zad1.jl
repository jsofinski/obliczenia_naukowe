# autor: Jakub Sofiński
using Printf
using Statistics



function findMacheps(T)
    macheps::T = 1.0

    while T(1.0) + (macheps/2) > 1.0
        macheps = macheps/2
    end

    println(macheps)
end
println("\nMacheps")
println("Float16")
findMacheps(Float16)
println(eps(Float16))

println("\nFloat32")
findMacheps(Float32)
println(eps(Float32))

println("\nFloat64")
findMacheps(Float64)
println(eps(Float64))

# FLT_EPSILON 1E-5
# DBL_EPSILON 1E-9
# LDBL_EPSILON 1E-9


function findEta(T)
    eta::T = 1.0

    while eta/2 > 0.0
        eta = eta/2
    end

    println(eta)
end

println("\nEta")

println("\nFloat16")
findEta(Float16)
println(nextfloat(Float16(0.0)))

println("\nFloat32")
findEta(Float32)
println(nextfloat(Float32(0.0)))

println("\nFloat64")
findEta(Float64)
println(nextfloat(Float64(0.0)))


function findMax(T)
    max::T = 2.0
    x::T = 2.0
    while x > 1
        while !isinf(max*x)
            max = max*x
        end
        x = (x+1)/2.0
    end
    println(max)
end

println("\nMAX")
println("\nFloat16")
findMax(Float16)
println(floatmax(Float16))

println("\nFloat32")
findMax(Float32)
println(floatmax(Float32))

println("\nFloat64")
findMax(Float64)
println(floatmax(Float64))

# println(bitstring(floatmin(Float32)))

# FLT_MAX 1E+37
# DBL_MAX 1E+37
# LDBL_MAX 1E+37