# autor: Jakub Sofiński
using Printf
using Statistics


p0 = Float64(0.01)
r = 3
n = 40

function my_func(n::Int, p0, r, T::Type, shouldPrint::Bool)
    result_standard = zeros(T, 0)
    last_p::T = p0::T
    for i in 0:n
        append!(result_standard, last_p)
        if shouldPrint
            print(i)
            print(" & ")
            println(last_p)
        end
        last_p = last_p + r * last_p * (1 - last_p)
    end
    return result_standard
end

function my_func_with_error(n::Int, p0, r, T::Type, shouldPrint::Bool)
    result_error = zeros(T, 0)
    last_p::T = p0::T
    for i in 0:n
        if i == 10 
            last_p = floor(last_p, digits=3)
        end
        append!(result_error, last_p)
        if shouldPrint
            print(i)
            print(" & ")
            println(last_p)
        end
        last_p = last_p + r * last_p * (1 - last_p)
    end
    return result_error
end

function printDataA(jump::Int)
    result_standard = my_func(n, p0, r, Float64, false)
    result_error = my_func_with_error(n, p0, r, Float64, false)
    for i in 0:jump:n
        print(i)
        print("     &    ")
        print(result_standard[i+1])
        print("     &    ")
        print(result_error[i+1])
        print("     &    ")
        print(abs(result_standard[i+1] - result_error[i+1]))
        println(" \\\\ \\hline")
    end
end

function printDataB(jump::Int)
    result_64 = my_func(n, p0, r, Float64, false)
    p0_32::Float32 = 0.01
    result_32 = my_func(n, p0_32, r, Float32, false)
    for i in 0:jump:n
        print(i)
        print("     &   ")
        print(result_32[i+1])
        print("     &   ")
        print(result_64[i+1])
        print("     &   ")
        print(abs(result_64[i+1] - result_32[i+1]))
        println(" \\\\ \\hline")
    end
end

printDataA(2)
printDataB(2)