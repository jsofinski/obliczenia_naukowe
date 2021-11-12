# autor: Jakub Sofiński
using Printf
using Statistics
using LinearAlgebra


function matcond(n::Int, c::Float64)
    # Function generates a random square matrix A of size n with
    # a given condition number c.
    # Inputs:
    #	n: size of matrix A, n>1
    #	c: condition of matrix A, c>= 1.0
    #
    # Usage: matcond(10, 100.0)
    #
    # Pawel Zielinski
    if n < 2
        error("size n should be > 1")
    end
    if c< 1.0
        error("condition number  c of a matrix  should be >= 1.0")
    end
    (U,S,V)=svd(rand(n,n))
    return U*diagm(0 =>[LinRange(1.0,c,n);])*V'
end

function hilb(n::Int)
    # Function generates the Hilbert matrix  A of size n,
    #  A (i, j) = 1 / (i + j - 1)
    # Inputs:
    #	n: size of matrix A, n>=1
    #
    #
    # Usage: hilb(10)
    #
    # Pawel Zielinski
    if n < 1
        error("size n should be >= 1")
    end
    return [1 / (i + j - 1) for i in 1:n, j in 1:n]
end


function getX(C)
    n = axes(C, 1)

    return fill(1, n)
end

function getSumOfDiff(x, y)
    sum = 0;
    n = length(x)
    for i in 1:n
        sum += abs(x[i] - y[i])
    end   
    return sum
end

size = 3
# c = 10.0
A = hilb(size)
# B = matcond(size, c)
b_vector = (A * getX(A))
# println(b_vector)

# # println(B)


# println(b_vector)

# println("Gauss:")
# result = A\b_vector
# println(result)
# println(norm(result))
# println(norm(result - getX(A))/norm(getX(A)))
# println(getSumOfDiff(result, getX(A)))

# println("Other:")
# result = inv(A)*b_vector
# println(result)
# println(result - getX(A))
# println(norm(result - getX(A))/norm(getX(A)))
# println(getSumOfDiff(result, getX(A)))

function getData_Hilbert_Gauss()
    n = 5
    max = 30
    jump = 5
    for i in n:jump:max
        A = hilb(i)
        x = getX(A)
        b_vector = (A * x)
        result = A\b_vector
        print(i)
        print(" & ")
        println((norm(result - x))/(norm(x)))
    end
end

function getData_Hilbert_Other()
    n = 5
    max = 30
    jump = 5
    for i in n:jump:max
        A = hilb(i)
        x = getX(A)
        b_vector = (A * x)
        result = inv(A)*b_vector
        print(i)
        print(" & ")
        println((norm(result - x))/(norm(x)))
    end
end

function getData_Random_Gauss()
    n = 5
    max = 20
    c = [1.0, 10.0, 10.0^3, 10.0^7, 10.0^12, 10.0^16]
    for i in n:5:20
        print(i)
        print(" & ")
        for j in 1:6
            A = matcond(i, c[j])
            x = getX(A)
            b_vector = (A * x)
            result = A\b_vector
            print((norm(result - x))/(norm(x)))
            print(" & ")
        end
        println()
    end
end

function getData_Random_Other()
    n = 5
    max = 20
    c = [1.0, 10.0, 10.0^3, 10.0^7, 10.0^12, 10.0^16]
    for i in n:5:20
        print(i)
        print(" & ")
        for j in 1:6
            A = matcond(i, c[j])
            x = getX(A)
            b_vector = (A * x)
            result = inv(A)*b_vector
            print((norm(result - x))/(norm(x)))
            print(" & ")
        end
        println()
    end
end

println("Hilbert_Gauss:")
getData_Hilbert_Gauss()
println("Hilbert_Other:")
getData_Hilbert_Other()
println("Random_Gauss:")
getData_Random_Gauss()
println("Random_Other:")
getData_Random_Other()