# autor: Jakub Sofiński
using Printf
using Statistics


function a(T) 
    S::T = 0
    for i in 1:length(x)
        S += (x[i]::T * y[i]::T)
    end
    println(S)
end

function b(T) 
    S::T = 0
    for i in length(x):-1:1
        S += (x[i]::T * y[i]::T)
    end
    println(S)
end

function c(T) 
    S::T = 0
    S_pos::T = 0
    S_neg::T = 0
    S_temp = Array{T}([])

    for i in 1:length(x)
        push!(S_temp, x[i]::T * y[i]::T)
    end

    sort!(S_temp)

    for i in length(S_temp):-1:1
        if S_temp[i] > 0
            S_pos += S_temp[i]
        end
    end

    for i in 1:length(S_temp)
        if S_temp[i] < 0
            S_neg += S_temp[i]
        end
    end

    S = S_neg + S_pos
    println(S)
end


function d(T) 
    S::T = 0
    S_pos::T = 0
    S_neg::T = 0
    S_temp = Array{T}([])

    for i in 1:length(x)
        push!(S_temp, x[i]::T * y[i]::T)
    end

    sort!(S_temp)

    for i in 1:length(S_temp)
        if S_temp[i] > 0
            S_pos += S_temp[i]
        end
    end

    for i in length(S_temp):-1:1
        if S_temp[i] < 0
            S_neg += S_temp[i]
        end
    end

    S = S_neg + S_pos
    println(S)
end


x = Float32[2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y = Float32[1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

println("Float32")
a(Float32)
b(Float32)
c(Float32)
d(Float32)


x = Float64[2.718281828, -3.141592654, 1.414213562, 0.5772156649, 0.3010299957]
y = Float64[1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]



println("\nFloat64")
a(Float64)
b(Float64)
c(Float64)
d(Float64)


println("\nZmienione dane:")

x = Float32[2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y = Float32[1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

println("Float32")
a(Float32)
b(Float32)
c(Float32)
d(Float32)


x = Float64[2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y = Float64[1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

println("\nFloat64")
a(Float64)
b(Float64)
c(Float64)
d(Float64)

