# autor: Jakub Sofiński
module Secant
export msiecznych

delta = 0.5 * 0.00001
epsilon = 0.5 * 0.00001

function myF(a) 
    return (a^2 - 4)
end

function sgn(a) 
    if a < 0.0
        return -1
    end
    return 1
end
#                   f, approx l,    approx r,    accuracy,       macheps,          max number of iterations
function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    r::Float64 = 0.0    # x_0
    v::Float64 = 0.0    # f(x_0)
    it = 0              # number of iterations
    err = 0             # 0 = :)     1 = :(

    fa = f(x0)
    fb = f(x1)
    if abs(fa) > abs(fb) 
        tempX = x0
        x0 = x1
        x1 = tempX
        tempF = fa
        fa = fb
        fb = tempF
    end

    while abs(x1 - x0) > delta && abs(fa) > epsilon && it < maxit
        if it >= maxit 
            err = 1
            break
        end
        it = it + 1
        s = (x1 - x0)/(fb -fa)
        x1 = x0
        fb = fa
        x0 = x0 - fa*s
        fa = f(x0)
    end
    return x0, fa, it, err

end

function test() 
    println(msiecznych(myF, -6.0, 1.0, delta, epsilon, 20))
    println(msiecznych(myF, -6.0, 2.1, delta, epsilon, 20))
    println(msiecznych(myF, 0.0, 3.0, delta, epsilon, 20))
    println(msiecznych(myF, 1.9, 2.1, delta, epsilon, 20))
    println(msiecznych(myF, -1000.0, 100.0, delta, epsilon, 20))
end

# test()

end