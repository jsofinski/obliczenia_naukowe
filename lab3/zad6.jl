# autor: Jakub Sofiński
using Printf
using Statistics

include("./bisection.jl")
include("./newton.jl")
include("./secant.jl")
using .Bisection
using .Newton
using .Secant

function firstF(x) 
    return (MathConstants.e^(1-x) - 1)
end 

function firstPf(x) 
    return -(MathConstants.e^(1-x))
end 

function secondF(x) 
    return (x * MathConstants.e^(-x))
end 

function secondPf(x) 
    return -(MathConstants.e^(-x) * (x-1))
end 

delta = 0.00001
epsilon = 0.00001

function test() 
    println("(e^(1-x) - 1)")
    println(mbisekcji(firstF, 0.0, 1.5, delta, epsilon))
    println(mstycznych(firstF, firstPf, 0.1, delta, epsilon, 10))
    println(msiecznych(firstF, 0.2, 0.3, delta, epsilon, 10))
    println("x * e^(-x)")
    println(mbisekcji(secondF, -1.0, 1.1, delta, epsilon))
    println(mstycznych(secondF, secondPf, 0.1, delta, epsilon, 10))
    println(msiecznych(secondF, -1.0, -0.8, delta, epsilon, 10))


    println()
    println(mstycznych(firstF, firstPf, 1.1, delta, epsilon, 10))
    println(mstycznych(firstF, firstPf, 2.0, delta, epsilon, 10))
    println(mstycznych(firstF, firstPf, 5.0, delta, epsilon, 100))
    println(mstycznych(firstF, firstPf, 7.0, delta, epsilon, 1000))
    println(mstycznych(firstF, firstPf, 8.0, delta, epsilon, 50))

    println()

    println(mstycznych(secondF, secondPf, 1.01, delta, epsilon, 100))
    println(mstycznych(secondF, secondPf, 1.1, delta, epsilon, 100))
    println(mstycznych(secondF, secondPf, 2.0, delta, epsilon, 100))
    println(mstycznych(secondF, secondPf, 10.0, delta, epsilon, 100))
    println(mstycznych(secondF, secondPf, 20.0, delta, epsilon, 100))
    println(mstycznych(secondF, secondPf, 100.0, delta, epsilon, 100))


    println()

    println(mstycznych(secondF, secondPf, 1.0, delta, epsilon, 10))

end
# test()

println(mstycznych(secondF, secondPf, 100.0, delta, epsilon, 100))
