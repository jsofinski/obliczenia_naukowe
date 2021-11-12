# autor: Jakub Sofiński
using Printf
using Statistics

# xd

function findX() 
    number::Float64 = 1
    
    while number * (1.0/number) == 1 
        number = nextfloat(Float64(number))
    end

    println(number)
end

function findAllX() 
    number::Float64 = 1
    
    while number < 2
        if number * (1.0/number) != 1
            println(number)
            println(number * (1.0/number))
        end

        number = nextfloat(Float64(number))
    end
end

findX()
findAllX()

println(1.000000057228997 * (1.0 / 1.000000057228997)) #min
# println(1.0000014660625551 * (1.0 / 1.0000014660625551)) #random

