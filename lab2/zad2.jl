# autor: Jakub Sofiński
using Printf
using Statistics


function lim() 
    x = 1
    last = 0
    new = 1
    while last != new 
        last = new
        new = (MathConstants.e)^x * log(1 + (MathConstants.e)^(-x))
        println(new)
        x += 1
    end
end

lim()
