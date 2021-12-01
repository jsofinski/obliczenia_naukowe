# autor: Jakub Sofiński
using Printf
using Statistics

include("./bisection.jl")
include("./newton.jl")
include("./secant.jl")
using .Bisection
using .Newton
using .Secant

function myF1(x) 
    return sin(x) - (((x)/2.0)^2)
end 

function myPf1(x) 
    return cos(x) - x/2.0
end 

function myF2(a) 
    return (a^2 - 4)
end

function myPf2(a) 
    return 2*a
end

delta = 0.5 * 0.00001
epsilon = 0.5 * 0.00001

function test(rExpected, vExpected, func, derivative, maxIt, left, right, x0, x1, x2) 

    rB, vB, itB, errB = mbisekcji(func, left, right, delta, epsilon)
    println(mbisekcji(func, left, right, delta, epsilon))
    rN, vN, itN, errN = mstycznych(func, derivative, x0, delta, epsilon, maxIt)
    println(mstycznych(func, derivative, x0, delta, epsilon, maxIt))
    rS, vS, itS, errS = msiecznych(func, x1, x2, delta, epsilon, maxIt)
    println(msiecznych(func, x1, x2, delta, epsilon, maxIt))
    if errB != 0
        println("Test bisection error")
    end
    if (rExpected - rB > delta)
        println("Test bisection wrong result")
    end
    if errN != 0
        println("Test newton error")
    end
    if (rExpected - rN > delta)
        println("Test newton wrong result")
    end
    if errS != 0
        println("Test secant error")
    end
    if (rExpected - rS > delta)
        println("Test secant wrong result")
    end
    
end

test(2.0, 0.0, myF2, myPf2, 10, 1.5, 2.0, 2.5 ,2.6, 2.7)
test(1.9337539672851562, 0.0, myF1, myPf1, 10, 1.0, 2.5, 1.5, 1.0, 2.0)

function myF(x) 
    return x
end 

function myPf(x) 
    return 1
end 

# println(mbisekcji(myF, 1.5, 2.0, delta, epsilon))
# println(mstycznych(myF, myPf, 1.5, delta, epsilon, 10))
# println(msiecznych(myF, 1.0, 2.0, delta, epsilon, 10))