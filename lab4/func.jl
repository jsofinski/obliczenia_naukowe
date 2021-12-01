# autor: Jakub Sofiński
module Func
using Plots

export ilorazyRoznicowe
export warNewton
export naturalna
export rysujNnfx


function ilorazRoznicowy(x::Vector{Float64}, f::Vector{Float64}, a::Int, b::Int) 
    if a == b 
        return f[a]
    end
    return ((ilorazRoznicowy(x, f, a+1, b)) - (ilorazRoznicowy(x, f, a, b-1)))/ (x[b] - x[a])
end

function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    fx = zeros(size(x))

    for i in eachindex(x)
        fx[i] = ilorazRoznicowy(x, f, 1, i)
    end

    return fx
end

function warNewtonIteration(x::Vector{Float64}, fx::Vector{Float64}, t::Float64, pos::Int) 
    if pos == size(fx)[1]
        return fx[pos]
    end
    return fx[pos] + (t - x[pos]) * warNewtonIteration(x, fx, t, (pos + 1))
end

function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)    
    # wn = fx
    # wk = fk
    # fk = zeros(size(fx))
    return warNewtonIteration(x, fx, t, 1)
end

function mulPoly(pa::Vector{Float64}, pb::Vector{Float64})
    length = size(pa)[1] + size(pb)[1] -1
    pc = zeros(length)
    for i = 1:(size(pa)[1])
        for j = 1:(size(pb)[1])
            # there is -1 in pc[i+j-1], bacause first index in julia is 1, not 0
            pc[i+j-1] = pc[i+j-1] + (pa[i] * pb[j])
        end
    end
    return pc
end

function naturalna(x::Vector{Float64}, fx::Vector{Float64})    
    length = size(fx)[1]
    a = [fx[length]]
    println(a)
    for i = (length-1):-1:1
        temp = [-x[i], 1.0]
        a = mulPoly(a, temp)
        a[1] = a[1] + fx[i] 
    end
    return a
end


function rysujNnfx(func,a::Float64,b::Float64,n::Int)
    x = zeros(n)
    f = zeros(n)
    for i in 1:n 
        x[i] = a + (b-a) * i/n
        f[i] = func(x[i])
    end
    println(x)
    println(f)
    fx = ilorazyRoznicowe(x, f)


    plotI = Plots.plot(x, f, label="funkcja interpolowana")
    savefig(plotI, "output_f.png")


    plotI = Plots.plot(x, fx, label="wielomian  interpolocayjny")
    savefig(plotI, "output_fx.png")

    return fx


end


x_test = [-2.0, -1.0, 0.0, 1.0, 2.0, 3.0]
f_test = [-25.0, 3.0, 1.0, -1.0, 27.0, 235.0]
# -25 + 28 - 15 + 5 

function myFunc(x::Float64)
    return (MathConstants.e)^x
end

function test()

    return rysujNnfx(myFunc, 0.0, 1.0, 10)
    # return ilorazyRoznicowe(x, f)
    # return warNewton(x, ilorazyRoznicowe(x, f), 2.0)
    # return naturalna(x, ilorazyRoznicowe(x, f))
    # return mulPoly([-2.0, -1.0, 0.0, 1.0, 2.0, 3.0],[-25.0, 3.0, 1.0, -1.0, 27.0, 235.0])
end

# println(ilorazyRoznicowe(x, f))
# println(test())
# println(warNewton(x, ilorazyRoznicowe(x, f), 1.21465))
# println(warNewton(x, ilorazyRoznicowe(x, f), 0.334734))
# println(warNewton(x, ilorazyRoznicowe(x, f), -1.38879))

test()
end