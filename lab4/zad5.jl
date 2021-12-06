# autor: Jakub Sofiński
using Printf
using Statistics

include("./func.jl")
using .Func

function func1(x::Float64)
    return (MathConstants.e)^x
end

function func2(x::Float64)
    return x^2 * sin(x)
end

function printData() 
    x0 = 0.5
    x1 = [0.0, 0.2, 0.4, 0.6000000000000001, 0.8, 1.0]
    f1 = [1.0, 1.2214027581601699, 1.4918246976412703, 1.822118800390509, 2.225540928492468, 2.718281828459045]
    println("Func 1, x=0.5")
    print("dokladna: ")
    println(func1(x0))
    print("wielomian: ")
    println(warNewton(x1, ilorazyRoznicowe(x1, f1), x0))
    print("Roznica: ")
    println(abs(func1(x0) - warNewton(x1, ilorazyRoznicowe(x1, f1), x0)))

    x0 = 0.9
    println("Func 1, x=0.9")
    print("dokladna: ")
    println(func1(x0))
    print("wielomian: ")
    println(warNewton(x1, ilorazyRoznicowe(x1, f1), x0))
    print("Roznica: ")
    println(abs(func1(x0) - warNewton(x1, ilorazyRoznicowe(x1, f1), x0)))


    x0 = 0.5
    x2 = [-1.0, -0.6, -0.19999999999999996, 0.20000000000000018, 0.6000000000000001, 1.0]
    f2 = [-0.8414709848078965, -0.20327129042221273, -0.007946773231802443, 0.007946773231802469, 0.20327129042221284, 0.8414709848078965]
    println("Func 2, x=0.5")
    print("dokladna: ")
    println(func2(x0))
    print("wielomian: ")
    println(warNewton(x2, ilorazyRoznicowe(x2, f2), x0))
    print("Roznica: ")
    println(abs(func2(x0) - warNewton(x2, ilorazyRoznicowe(x2, f2), x0)))
    x0 = 0.9
    println("Func 2, x=0.9")
    print("dokladna: ")
    println(func2(x0))
    print("wielomian: ")
    println(warNewton(x2, ilorazyRoznicowe(x2, f2), x0))
    print("Roznica: ")
    println(abs(func2(x0) - warNewton(x2, ilorazyRoznicowe(x2, f2), x0)))
end

# printData()

rysujNnfxName(func1, 0.0, 1.0, 5, "5_1_5.png", "e^x, n=5")
rysujNnfxName(func1, 0.0, 1.0, 10, "5_1_10.png", "e^x, n=10")
rysujNnfxName(func1, 0.0, 1.0, 15, "5_1_15.png", "e^x, n=15")
rysujNnfxName(func2, -1.0, 1.0, 5, "5_2_5.png", "x^2*sinx, n=5")
rysujNnfxName(func2, -1.0, 1.0, 10, "5_2_10.png", "x^2*sinx, n=10")
rysujNnfxName(func2, -1.0, 1.0, 15, "5_2_15.png", "x^2*sinx, n=15")