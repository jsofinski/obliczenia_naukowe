# autor: Jakub Sofiński
using Printf
using Statistics

include("./bisection.jl")
include("./newton.jl")
include("./secant.jl")
using .Bisection
using .Newton
using .Secant

function myF(x) 
    return sin(x) - (((x)/2.0)^2)
end 

function myPf(x) 
    return cos(x) - x/2.0
end 

delta = 0.5 * 0.00001
epsilon = 0.5 * 0.00001
println(mbisekcji(myF, 1.5, 2.0, delta, epsilon))
println(mstycznych(myF, myPf, 1.5, delta, epsilon, 10))
println(msiecznych(myF, 1.0, 2.0, delta, epsilon, 10))