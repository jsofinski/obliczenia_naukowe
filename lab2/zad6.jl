# autor: Jakub Sofiński
using Printf
using Statistics
using Plots




function my_func(n::Int, c, x, shouldPrint::Bool)
    result = zeros(Float64, 0)
    last_x::Float64 = x::Float64
    for i in 0:n
        append!(result, last_x)
        if shouldPrint
            print(i)
            print(" & ")
            println(last_x)
        end
        last_x = ((last_x * last_x) + c)
    end
    return result
end


function printData2(jump::Int)
    result1 = my_func(40, -2.0, 1.0, false)
    result2 = my_func(40, -2.0, 2.0, false)
    result3 = my_func(40, -2.0, 1.99999999999999, false)
    
    for i in 0:jump:40
        print("     &    ")
        print(i)        
    end
    println(" \\\\ \\hline")
    for i in 0:jump:40
        print("     &    ")
        print(result1[i+1])
    end
    println(" \\\\ \\hline")
    for i in 0:jump:40
        print("     &    ")
        print(result2[i+1])
    end
    println(" \\\\ \\hline")
    for i in 0:jump:40
        print("     &    ")
        print(result3[i+1])
    end
    println(" \\\\ \\hline")
end

function printData2_2(jump::Int)
    result1 = my_func(40, -2.0, 1.0, false)
    result2 = my_func(40, -2.0, 2.0, false)
    result3 = my_func(40, -2.0, 1.99999999999999, false)
    
    for i in 0:jump:40
        print(i)        
        print("     &    ")
        print(result1[i+1])
        print("     &    ")
        print(result2[i+1])
        print("     &    ")
        print(result3[i+1])
        println(" \\\\ \\hline")
    end
end

function printData1(jump::Int)
    result4 = my_func(40, -1.0, 1.0, false)
    result5 = my_func(40, -1.0, -1.0, false)
    result6 = my_func(40, -1.0, 0.75, false)
    result7 = my_func(40, -1.0, 0.25, false)
    # for i in 0:jump:40
    #     print(i) 
    #     print("     &    ")
    # end
    for i in 0:jump:40
        print("     &    ")
        print(result4[i+1])
    end
    println(" \\\\ \\hline")
    for i in 0:jump:40
        print("     &    ")
        print(result5[i+1])
    end
    println(" \\\\ \\hline")
    for i in 0:jump:40
        print("     &    ")
        print(result6[i+1])
    end
    println(" \\\\ \\hline")
    for i in 0:jump:40
        print("     &    ")
        print(result7[i+1])
    end
    println(" \\\\ \\hline")
end

function printData1_2(jump::Int)
    result4 = my_func(40, -1.0, 1.0, false)
    result5 = my_func(40, -1.0, -1.0, false)
    result6 = my_func(40, -1.0, 0.75, false)
    result7 = my_func(40, -1.0, 0.25, false)
    
    for i in 0:jump:40
        print(i) 
        print("     &    ")
        print(result4[i+1])
        print("     &    ")
        print(result5[i+1])
        print("     &    ")
        print(result6[i+1])
        print("     &    ")
        print(result7[i+1])
        println(" \\\\ \\hline")
    end
    
end

# my_func(40, -2.0, 1.0, true)
# my_func(40, -2.0, 2.0, true)
# my_func(40, -2.0, 1.99999999999999, true)
# my_func(40, -1.0, 1.0, true)
# my_func(40, -1.0, -1.0, true)
# my_func(40, -1.0, 0.75, true)
# my_func(40, -1.0, 0.25, true)
printData2_2(5)
printData1_2(5)
printData1_2(1)

# x = 0:40; y = rand(10); # These are the plotting data
# result6 = my_func(40, -1.0, 0.75, false)
# plot(x, result6)
# savefig("myplot.png")