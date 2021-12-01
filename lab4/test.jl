# autor: Jakub Sofiński
using Printf
using Statistics

include("./func.jl")
using .Func

println(rysujNnfx((x -> sin(x)-((1/2)*x)^2), 1.0, 1.0, 1))