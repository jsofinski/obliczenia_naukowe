module Blocksys

using Printf
using Statistics

export func1
export readMatrix
export readVector
export calcEquations
export calcEquationsWithX
export myGauss
export myGaussWithPartialPivoting
export calcRelativeError
export myOptimalGauss
export myOptimalGaussWithPartialPivoting
export readRawMatrix
export getRigthVector

function func1()
    return 1
end

function readRawMatrix(fileName::String) 
    data = readlines(fileName)
    numbers = split(data[1], " ")

    aSize = parse(Int64, numbers[1])
    dataSize = length(data)

    AMatrix = zeros(Float64, (aSize, aSize))

    for i in 2:(dataSize)
        numbers = split(data[i], " ")
        iPos = parse(Int64, numbers[1])
        jPos = parse(Int64, numbers[2])
        value = parse(Float64, numbers[3])
        AMatrix[iPos, jPos] = value
        # println(value)
    end

    return AMatrix

end
function readMatrix(fileName::String) 
    data = readlines(fileName)
    numbers = split(data[1], " ")

    aSize = parse(Int64, numbers[1])
    blockSize = parse(Int64, numbers[2])
    dataSize = length(data)

    optMatrix = zeros(Float64, (aSize, 3 + blockSize))

    for i in 2:(dataSize)
        numbers = split(data[i], " ")
        iPos = parse(Int64, numbers[1])
        jPos = parse(Int64, numbers[2])
        value = parse(Float64, numbers[3])
        # println(value)
    end


    for i in 2:(dataSize)
        numbers = split(data[i], " ")
        iPos = parse(Int64, numbers[1])
        jPos = parse(Int64, numbers[2])
        value = parse(Float64, numbers[3])

        optJ = 0
        # Ck
        if jPos - iPos == 4 
            optJ = blockSize + 3
            optMatrix[iPos, optJ] = value
        # Ak
        elseif ceil(iPos/blockSize) == ceil(jPos/blockSize)
            optJ = (jPos + blockSize - 1)%4 + 3
            optMatrix[iPos, optJ] = value
        # Bk
        else
            optJ = (jPos+2)%blockSize
            optMatrix[iPos, optJ] = value
        end
        # println(value)
    end

    # println(size(AMatrix))
    # println(dataSize)
    # println(aSize)
    # println(blockSize)

    # show(stdout, "text/plain", optMatrix)
    # println()
    return optMatrix
end

function readVector(fileName::String) 
    data = readlines(fileName)
    numbers = split(data[1], " ")
    size = parse(Int64, numbers[1])
    dataSize = length(data)

    b::Vector{Float64} = []
    for i in 2:(dataSize)
        numbers = split(data[i], " ")
        push!(b, parse(Float64, numbers[1]))
    end

    # println(b)
    return b
end

function calcEquations(A::Matrix{Float64}, b::Vector{Float64})
    return A\b
end


function myGauss(A::Matrix{Float64}, b::Vector{Float64})
    matrixSize = size(A, 1)
    x = zeros(matrixSize)
    # elimination
    for i in 1:matrixSize
        for j in i+1:matrixSize
            if A[j, i] == 0
                continue
            end
            factor = A[j, i]/A[i, i]
            for k in i:matrixSize
                A[j, k] = A[j, k] - A[i, k] * factor
            end
            b[j] = b[j] - b[i] * factor
        end
    end

    # show(stdout, "text/plain", A)

    x[matrixSize] = b[matrixSize]/A[matrixSize, matrixSize]
    for i in matrixSize-1:-1:1
        sum = 0.0
        for j in (i+1):matrixSize
            # println(j)
            sum += A[i,j] * x[j]
            x[i] = (b[i] - sum)/A[i,i]
        end
    end
    return x
end

function myOptimalGauss(A::Matrix{Float64}, b::Vector{Float64})
    columnSize = size(A, 1)
    rowSize = size(A, 2)

    l = rowSize-3
    newRowSize = (rowSize + l - 1)

    matrix = zeros(Float64, (columnSize, newRowSize))

    for i in 1:columnSize
        for j in 1:rowSize-1
            matrix[i, j] = A[i, j]
        end
        matrix[i, rowSize + (i+3)%l] = A[i, rowSize]
    end

    # show(stdout, "text/plain", A)
    # show(stdout, "text/plain", matrix)

    # println(l)
    # println(columnSize)
    # println()
    # println()
    # println()

    # elimination
    for i in 1:columnSize
        if i%4 == l-1
            rowsToEliminate = l + 1
        elseif i%4 == 0
            rowsToEliminate = l
        else 
            rowsToEliminate = l - i%4
        end
        # println(rowsToEliminate)
        # dla l = 4 
        # 1 = 3 # 2 = 2 # 3 = 5 # 0 = 4
        # dla l = 5
        # 1 = 4 # 2 = 3 # 3 = 2 # 4 = 6 # 0 = 5

        diagonalIndex = (i+l-1)%l + 3
        currentValue = matrix[i, diagonalIndex]
        for j in i+1:i+rowsToEliminate
            if j > columnSize
                continue
            end
            # if matrix[i, j] == 0
            #     continue
            # end
            if ceil(j/l) > ceil(i/l)
                if (i%l == 0) 
                    startIndex = 2
                else 
                    startIndex = 1
                end
            else 
                startIndex = diagonalIndex
            end
            factor = matrix[j, startIndex]/currentValue
            # println("i: ",i, "  start: ", startIndex)
            iteration = 0
            for k in startIndex:startIndex+l
                # println("startIndex: ", startIndex)
                # println("i: ", i, " ; k: ", k)
                # println("iteration: ", iteration)
                # println("diagonalIndex: ", diagonalIndex)
                matrix[j, k] = matrix[j, k] - matrix[i, diagonalIndex+iteration] * factor
                iteration += 1
            end
            
            b[j] = b[j] - b[i] * factor
        end
    end
    # show(stdout, "text/plain", A)
    # show(stdout, "text/plain", matrix)

    x = zeros(columnSize)
    x[columnSize] = b[columnSize]/matrix[columnSize, l+2]
    # println(matrix[columnSize, newRowSize])
    for i in columnSize-1:-1:1
        sum = 0.0
        iteration = 1
        for j in (i+1):(i+1)+l
            if j > columnSize || iteration > l
                continue
            end
            jPosDiagonal = (i+l-1)%l + 3 
            # println(matrix[i,jPosDiagonal])
            jPosCurrent = jPosDiagonal + iteration
            sum += matrix[i,jPosCurrent] * x[j]
            x[i] = (b[i] - sum)/matrix[i,jPosDiagonal]
            iteration += 1
        end
    end
    return x
end

function myOptimalGaussWithPartialPivoting(A::Matrix{Float64}, b::Vector{Float64})
    columnSize = size(A, 1)
    rowSize = size(A, 2)

    l = rowSize-3
    newRowSize = (rowSize + l - 1)

    matrix = zeros(Float64, (columnSize, newRowSize))

    for i in 1:columnSize
        for j in 1:rowSize-1
            matrix[i, j] = A[i, j]
        end
        matrix[i, rowSize + (i+3)%l] = A[i, rowSize]
    end
    # println(sizeof(matrix))

    # move first row to the left
    # for i in 1:l+1
    #     matrix[1, i] = matrix[1, 2 + i]
    #     matrix[1, 2 + i] = 0.0
    #     println(i)
    # end

    # show(stdout, "text/plain", matrix)
    # show(stdout, "text/plain", matrix)

    # println(l)
    # println(columnSize)
    # println()
    # println()
    # println()

    # elimination
    for i in 1:columnSize
        diagonalIndex = (i+l-1)%l + 3

        for j in 1:newRowSize
            if diagonalIndex + j - 1 > newRowSize
                break
            end
            matrix[i, j] = matrix[i, diagonalIndex + j - 1]
            matrix[i, diagonalIndex + j - 1] = 0.0
        end

        if i%4 == l-1
            rowsToEliminate = l + 1
        elseif i%4 == 0
            rowsToEliminate = l
        else 
            rowsToEliminate = l - i%4
        end
        # println(rowsToEliminate)
        # dla l = 4 
        # 1 = 3 # 2 = 2 # 3 = 5 # 0 = 4
        # dla l = 5
        # 1 = 4 # 2 = 3 # 3 = 2 # 4 = 6 # 0 = 5


        # # PARITAIL * PIVOTING HERE
        # # FIND MAX VALUE IN COLUMN AND SWITCH ROWS

        # show(stdout, "text/plain", matrix)
        maxIndex = i
        maxValue = abs(matrix[i, 1])
        startIndex = 1

        for j in i+1:i+rowsToEliminate
            if j > columnSize 
                continue
            end
            if ceil(j/l) > ceil(i/l)
                if (i%l == 0) 
                    startIndex = 2
                else 
                    startIndex = 1
                end
            else 
                startIndex = diagonalIndex
            end
            if abs(matrix[j, startIndex]) > maxValue
                maxIndex = j
                maxValue = abs(matrix[j, startIndex])
            end
        end

        if maxIndex != i
            # println("Swap current: ", i, " with ", maxIndex, " value: ", maxValue)
            # swap i with maxIndex

            if ceil(maxIndex/l) > ceil(i/l)
                if (i%l == 0) 
                    startIndex = 2
                else 
                    startIndex = 1
                end
            else 
                startIndex = diagonalIndex
            end

            for j in 1:newRowSize
                if (startIndex + j - 1) > newRowSize
                    break
                end
                # println("Swap ", maxIndex, ", ", startIndex+j-1, " with ", i, " ",j)
                temp = matrix[maxIndex,startIndex+j-1]
                matrix[maxIndex, startIndex+j-1] = matrix[i, j]
                matrix[i, j] = temp 
            end
            # return

            # swap vector values
            temp = b[maxIndex]
            b[maxIndex] = b[i]
            b[i] = temp 
        end
        

        currentValue = matrix[i, 1]
        for j in i+1:i+rowsToEliminate
            if j > columnSize
                continue
            end
            if ceil(j/l) > ceil(i/l)
                if (i%l == 0) 
                    startIndex = 2
                else 
                    startIndex = 1
                end
            else 
                startIndex = diagonalIndex
            end
            factor = matrix[j, startIndex]/currentValue
            # println("i: ",i, "  start: ", startIndex)
            iteration = 0
            for k in startIndex:newRowSize
                if k > newRowSize
                    break
                end
                matrix[j, k] = matrix[j, k] - matrix[i, 1+iteration] * factor
                iteration += 1
            end
            b[j] = b[j] - b[i] * factor
        end
    end
    # show(stdout, "text/plain", A)
    # println()
    # show(stdout, "text/plain", matrix)

    x = zeros(columnSize)
    x[columnSize] = b[columnSize]/matrix[columnSize, 1]
    # println(matrix[columnSize, newRowSize])
    for i in columnSize-1:-1:1
        sum = 0.0
        iteration = 0
        xIndex = i
        for j in (i+1):(i+1)+newRowSize
            if j > columnSize || 2 + iteration > newRowSize
                continue
            end
            sum += matrix[i,2 + iteration] * x[j]
            x[i] = (b[i] - sum)/matrix[i,1]
            iteration += 1
        end
    end
    return x
end

function myGaussWithPartialPivoting(A::Matrix{Float64}, b::Vector{Float64})
    matrixSize = size(A, 1)
    x = zeros(matrixSize)
    # elimination
    
    for i in 1:matrixSize
        # PARITAIL * PIVOTING HERE
        # FIND MAX VALUE IN COLUMN AND SWITCH ROWS
        maxIndex = i
        maxValue = abs(A[i, i])

        # show(stdout, "text/plain", A)
        for j in i+1:matrixSize
            if abs(A[j, i]) > maxValue
                maxIndex = j
                maxValue = abs(A[j, i])
            end
        end
        if maxIndex != i 
            # swap i with maxIndex
            # println("Swap current: ", i, " with ", maxIndex, " value: ", maxValue)
            for j in i:matrixSize
                temp = A[maxIndex,j]
                A[maxIndex, j] = A[i, j]
                A[i, j] = temp 
            end

            # swap vector values
            temp = b[maxIndex]
            b[maxIndex] = b[i]
            b[i] = temp 
        end
        # show(stdout, "text/plain", A)

        for j in i+1:matrixSize
            if A[j, i] != 0
                factor = A[j, i]/A[i, i]
                for k in i:matrixSize
                    A[j, k] = A[j, k] - A[i, k] * factor
                end
                b[j] = b[j] - b[i] * factor
            end
        end
    end
    # show(stdout, "text/plain", A)

    x[matrixSize] = b[matrixSize]/A[matrixSize, matrixSize]
    for i in matrixSize-1:-1:1
        sum = 0.0
        for j in (i+1):matrixSize
            sum += A[i,j] * x[j]
            x[i] = (b[i] - sum)/A[i,i]
        end
    end
    return x
end

function getRigthVector(A::Matrix{Float64})
    matrixSize = size(A, 1)
    x = ones(matrixSize)
    b = zeros(matrixSize)

    sum = 0.0
    # for i in 1:matrixSize
    #     sum = 0.0
    #     for j in 1:matrixSize
    #         sum += A[i, j]
    #     end
    #     b[i] = sum
    # end

    rowSize = size(A, 2)
    l = rowSize-3
    newRowSize = (rowSize + l - 1)

    for i in 1:matrixSize
        sum = 0.0
        for j in 1:rowSize
            sum += A[i, j]
        end
        b[i] = sum
    end


    return b
end

function calcEquationsWithX(A::Matrix{Float64}) 
    matrixSize = size(A)[1]
    x = ones(Float64, (matrixSize, 1))
    return calcEquations(A, x)
end

function norm(a::Vector{Float64})
    sum = 0.0
    for i in 1:length(a)
        sum += a[i]^2.0
    end
    return sqrt(sum)
end
function calcRelativeError(b::Vector{Float64}, x::Vector{Float64})
    # println(norm(b))
    # println(norm(x))
    # println((b-x))
    return (norm(b - x)/norm(x))
end 


end