using Printf
using Statistics
using BenchmarkTools

include("./blocksys.jl")
using .Blocksys
include("./matrixgen.jl")
using .matrixgen


# czytanie danej macierzy A i wektora prawych stron b z
A = readMatrix("data/100000/A.txt")
b = readVector("data/100000/b.txt")

# czytanie danej macierzy A z pliku tekstowego (format opisany wyżej)
#  oraz obliczanie wektora prawych stron b na podstawie wektora x
A = readMatrix("data/100000/A.txt")
b = getRigthVector(A)

# drukowanie obliczonego rozwiązania xˆ do pliku tekstowego,
# jeśli macierz A i wektor prawychstron b były czytane z plików
A = readMatrix("data/100000/A.txt")
b = readVector("data/100000/b.txt")
result = myOptimalGaussWithPartialPivoting(A, b)
result = myOptimalGauss(A, b)
println(result)


# # main()
# A = readRawMatrix("data/16/A.txt")
# println(sizeof(A))
# show(stdout, "text/plain", A)
# b = readVector("data/16/b.txt")
# testA = [3.0 -2.0 5.0 0.0; 4.0 5.0 8.0 1.0; 1.0 1.0 2.0 1.0; 2.0 7.0 6.0 5.0]
# testb = [2.0,4.0,5.0,7.0]
# # println(b)
# # println(calcEquationsWithX(A))
# # println(b)
# result = (myGaussWithPartialPivoting(A, b))

# println()
# # println(result)
# # println(calcRelativeError(result, ones(Float64, length(result))))

# println()
# # println(result)
A = readMatrix("data/100000/A.txt")
b = readVector("data/100000/b.txt")
result = myOptimalGaussWithPartialPivoting(A, b)
println(calcRelativeError(result, ones(Float64, length(result))))

A = readMatrix("data/100000/A.txt")
b = getRigthVector(A)
result = myOptimalGaussWithPartialPivoting(A, b)
println(calcRelativeError(result, ones(Float64, length(result))))

# println(sizeof(A))
# # result = (myOptimalGauss(A, b))
result = myOptimalGaussWithPartialPivoting(A, b)
# # println(result)
# # println(b)
# # println(calcEquations(A, b))

# println(calcRelativeError(result, ones(Float64, length(result))))


# println(b)
# println(getRigthVector(A))

