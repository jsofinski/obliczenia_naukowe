# autor: Jakub Sofiński
using Printf
using Statistics

include("./bisection.jl")
include("./newton.jl")
include("./secant.jl")
using .Bisection
using .Newton
using .Secant

delta = 0.5 * 0.00001
epsilon = 0.5 * 0.00001

function firstF(x) 
    return 3x
end 

function secondF(x) 
    return (MathConstants.e^x)
end 

function myF(x) 
    return return firstF(x) - secondF(x)
end 

function findX(min, jump, max, numberOfX) 
    left = min
    right = left + jump
    numberOfFound = 0

    while true
        x, y, it, err = mbisekcji(myF, left, right, delta, epsilon)
        if err == 1 
            left = left + jump
            right = right + jump
        else 
            numberOfFound = numberOfFound + 1
            println(mbisekcji(myF, left, right, delta, epsilon))
            if numberOfFound == numberOfX
                break
            end
        end 

        left = left + jump
        right = right + jump

        if left > max 
            numberOfFound = 0
            jump = jump/2.0
            left = min
            right = min + jump
        end 
    end 
end

# println(mbisekcji(myF, 0.0, 10.0, delta, epsilon))
min = -10.0
jump = 2.0
max = 10.0
findX(min, jump, max, 2)
# println(mbisekcji(myF, 1.5, 2.0, delta, epsilon))
# println(mbisekcji(myF, 0.0, 1.5, delta, epsilon))
