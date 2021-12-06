# autor: Jakub Sofiński
module Func
using Plots

export ilorazyRoznicowe
export warNewton
export naturalna
export rysujNnfx
export rysujNnfxName

function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    fx = zeros(size(x))
    old = zeros(size(x))
    new = zeros(size(x))

    for i in eachindex(f) 
        old[i] = f[i]
    end

    for i in 1:(size(x)[1]-1)
        fx[i] = old[1]
        current_size = size(x)[1] - i
        new = zeros(current_size)
        for j in 1:current_size
            new[j] = (old[j+1] - old[j])/(x[j + size(x)[1] - current_size] - x[j])
        end 
        old = new
    end
    fx[size(x)[1]] = old[1]

    
    return fx
end

function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)   
    v = fx[length(fx)]
    for i in (length(fx)-1):-1:1
        v = fx[i] + v * (t - x[i])
    end
    return v
end

function multiplyPolynomial(pa::Vector{Float64}, pb::Vector{Float64})
    n = length(pa) + length(pb) -1
    pc = zeros(n)
    for i = 1:(length(pa))
        for j = 1:(length(pb))
            pc[i+j-1] = pc[i+j-1] + (pa[i] * pb[j]) 
        end
    end
    return pc
end

function naturalna(x::Vector{Float64}, fx::Vector{Float64})    
    n = length(fx)
    a = [fx[n]]
    for i = (n-1):-1:1
        temp = [-x[i], 1.0] # x - x_i
        a = multiplyPolynomial(a, temp)
        a[1] = a[1] + fx[i] 
    end
    return a
end


function rysujNnfx(func,a::Float64,b::Float64,n::Int)
    size = n + 1
    accuracy = 10
    x = zeros(size)
    f = zeros(size)
    for i in 1:size
        x[i] = a + (i-1)*((b-a)/n)
        f[i] = func(x[i])
    end
    temp = ilorazyRoznicowe(x, f)

    xfunc = zeros(n*accuracy)
    yfunc = zeros(n*accuracy)

    for i in 1:accuracy*n
        xfunc[i] = a + (i-1)*((b-a)/(accuracy*n))
        yfunc[i] = func(xfunc[i])
    end
    plot(xfunc, yfunc, label="funkcja interpolowana")

    for i in 1:accuracy*n 
        yfunc[i] = warNewton(x, temp, xfunc[i])
    end
    plot!(xfunc, yfunc, label="wielomian  interpolocayjny", linecolor="red")
    savefig("output.png")
end

function rysujNnfxName(func,a::Float64,b::Float64,n::Int,fileName::String,myTitle::String)
    size = n + 1
    accuracy = 10
    x = zeros(size)
    f = zeros(size)
    for i in 1:size
        x[i] = a + (i-1)*((b-a)/n)
        f[i] = func(x[i])
    end
    # print("x: ")
    # println(x)
    # print("f: ")
    # println(f)
    temp = ilorazyRoznicowe(x, f)

    xfunc = zeros(n*accuracy)
    yfunc = zeros(n*accuracy)

    for i in 1:accuracy*n
        xfunc[i] = a + (i-1)*((b-a)/(accuracy*n))
        yfunc[i] = func(xfunc[i])
    end
    plot(xfunc, yfunc, label="funkcja interpolowana")

    for i in 1:accuracy*n 
        yfunc[i] = warNewton(x, temp, xfunc[i])
    end
    plot!(xfunc, yfunc, label="wielomian  interpolocayjny", title = myTitle, linecolor="red")
    savefig(fileName)
end


function tests() 
    x1 = [-1.0, 0.0, 1.0, 2.0]
    f1 = [3.0, -4.0, 5.0, -6.0]
    iloraz1 = ilorazyRoznicowe(x1, f1)
    naturalna1 = [-4.0, 7.0, 8.0, -6.0]

    x2 = [3.0, 1.0, 5.0, 6.0]
    f2 = [1.0, -3.0, 2.0, 4.0]
    iloraz2 = ilorazyRoznicowe(x2, f2)
    naturalna2 = [-8.75, 7.525, -1.9500000000000002, 0.17500000000000002]

    x3 = [-2.0, -1.0, 0.0, 1.0, 2.0, 3.0]
    f3 = [-25.0, 3.0, 1.0, -1.0, 27.0, 235.0]
    iloraz3 = ilorazyRoznicowe(x3, f3)
    naturalna3 = [1.0, -3.0, 0.0, 0.0, 0.0, 1.0]

    epsilon = 0.0001

    if naturalna(x1, iloraz1) != naturalna1 
        println("Test 1 error")
    end
    if naturalna(x2, iloraz2) != naturalna2 
        println("Test 2 error")
    end
    if naturalna(x3, iloraz3) != naturalna3
        println("Test 3 error")
    end
    if warNewton(x3, ilorazyRoznicowe(x3, f3), 0.1) - 0.70001 > epsilon
        println("Test 5 error")
    end
    if warNewton(x3, ilorazyRoznicowe(x3, f3), 0.0) - 1.0 > epsilon
        println("Test 5 error")
    end

    # println(ilorazyRoznicowe(x1,f1))
    # println(iloraz1)
    # println(ilorazyRoznicowe(x2,f2))
    # println(iloraz2)
end

x_test = [-2.0, -1.0, 0.0, 1.0, 2.0, 3.0]
f_test = [-25.0, 3.0, 1.0, -1.0, 27.0, 235.0]
# -25 + 28 - 15 + 5 

function myFunc(x::Float64)
    # return (MathConstants.e)^x
    return x^2 * sin(x)
    # return abs(x)
    # return 1/(1+x^2)
end

function test()

    # println(warNewton(x_test, ilorazyRoznicowe(x_test, f_test), 1.21465))
    # println(warNewton(x_test, ilorazyRoznicowe(x_test, f_test), 0.334734))
    # println(warNewton(x_test, ilorazyRoznicowe(x_test, f_test), -1.38879))

    # println(warNewton_2(x_test, ilorazyRoznicowe(x_test, f_test), 1.21465))
    # println(warNewton_2(x_test, ilorazyRoznicowe(x_test, f_test), 0.334734))
    # println(warNewton_2(x_test, ilorazyRoznicowe(x_test, f_test), -1.38879))

    println(ilorazyRoznicowe(x_test, f_test))
    println(naturalna(x_test, ilorazyRoznicowe(x_test, f_test)))
    # return rysujNnfx(myFunc, -1.0, 1.0, 3)
    # return rysujNnfx(myFunc, -5.0, 5.0, 5)
    # return ilorazyRoznicowe(x_test, f_test)
    # return warNewton(x, ilorazyRoznicowe(x, f), 2.0)
    # return naturalna(x_test, ilorazyRoznicowe(x_test, f_test))
    # return multiplyPolynomial([-2.0, -1.0, 0.0, 1.0, 2.0, 3.0],[-25.0, 3.0, 1.0, -1.0, 27.0, 235.0])
end

# println(ilorazyRoznicowe(x, f))
# println(test())
test()
# tests()
end