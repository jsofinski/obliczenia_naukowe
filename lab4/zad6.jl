# autor: Jakub Sofiński
using Printf
using Statistics

include("./func.jl")
using .Func

function func1(x::Float64)
    return abs(x)
end

function func2(x::Float64)
    return 1/(1 + x^2)
end

rysujNnfxName(func1, -1.0, 1.0, 5, "6_1_5.png", "abs(x), n=5")
rysujNnfxName(func1, -1.0, 1.0, 10, "6_1_10.png", "abs(x), n=10")
rysujNnfxName(func1, -1.0, 1.0, 15, "6_1_15.png", "abs(x), n=15")
rysujNnfxName(func2, -5.0, 5.0, 5, "6_2_5.png", "1/(1 + x^2), n=5")
rysujNnfxName(func2, -5.0, 5.0, 10, "6_2_10.png", "1/(1 + x^2), n=10")
rysujNnfxName(func2, -5.0, 5.0, 15, "6_2_15.png", "1/(1 + x^2), n=15")

