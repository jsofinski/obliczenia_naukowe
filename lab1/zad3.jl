# autor: Jakub Sofiński
using Printf
using Statistics

println("Float64(1.0)")
println(bitstring(Float64(1.0)))
println("nextfloat(Float64(1.0))")
println(bitstring(nextfloat(Float64(1.0))))
println("Float64(1.0) - nextfloat(Float64(1.0))")
println(Float64(1.0) - nextfloat(Float64(1.0)))
@printf("2^(-52) = ")
println(2^(-52))

# println(Float64(1.5123) - nextfloat(Float64(1.5123)))

println()

println("Float64(0.5)")
println(bitstring(Float64(0.5)))
println("nextfloat(Float64(0.5))")
println(bitstring(nextfloat(Float64(0.5))))
println("Float64(0.5) - nextfloat(Float64(0.5))")
println(Float64(0.5) - nextfloat(Float64(0.5)))
@printf("2^(-53) = ")
println(2^(-53))
println()

println("Float64(2.0)")
println(bitstring(Float64(2.0)))
println("nextfloat(Float64(2.0))")
println(bitstring(nextfloat(Float64(2.0))))
println("Float64(2.0) - nextfloat(Float64(2.0))")
println(Float64(2.0) - nextfloat(Float64(2.0)))
@printf("2^(-51) = ")
println(2^(-51))
println()
