# autor: Jakub Sofiński
using Printf
using Statistics



function myFunction(x::Float64)
    return Float64(sin(x) + cos(3.0 * x))
end

function myFunctionDerivative(x::Float64)
    return Float64(cos(x) - 3 * sin(3.0 * x))
end

function calcValue(x::Float64, h::Float64) 
    return (Float64(myFunction(x + h) - myFunction(x)) / h)
end

for i = 0:-1:-54
    println()
    println("2^{$i}")
    println(calcValue(1.0, 2.0^(i)))
    println(myFunctionDerivative(1.0))
    println(abs(calcValue(1.0, 2.0^(i)) - myFunctionDerivative(1.0)))

end


# for i = 0:-1:-54

#     @printf("\${2^{%d}}\$ \t & ", i)
#     @printf("\${%.17f}\$ \t & ", calcValue(1.0, 2.0^(i)))
#     @printf("\${%.17f}\$ \t & ", myFunctionDerivative(1.0 + 2.0^(i)))
#     @printf("\${%.17f}\$ \t \\\\ \\hline\n", abs(calcValue(1.0, 2.0^(i)) - myFunctionDerivative(1.0 + 2.0^(i))))
#     # println((myFunction(1.0 + 2.0^(i)) - myFunction(1.0)) / 2^(i))

# end

for  i = 0:-1:-54
    @printf("(%d,%.17f)", (-i),abs(calcValue(1.0, 2.0^(i)) - myFunctionDerivative(1.0 + 2.0^(i))))

end