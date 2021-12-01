# autor: Jakub Sofiński
module Newton
export mstycznych

delta = 0.5 * 0.00001
epsilon = 0.5 * 0.00001

function myF(a) 
    return (a^2 - 4)
end

function myPf(a) 
    return 2*a
end

function sgn(a) 
    if a < 0.0
        return -1
    end
    return 1
end

#                   f, f', approximation,accuracy,       macheps,          max number of iterations
function mstycznych(f, pf, x_0::Float64, delta::Float64, epsilon::Float64, maxit) 
    r::Float64 = 0.0    # x_1
    v::Float64 = 0.0    # f(x_0)
    it = 0              # number of iterations
    err = 0             # 0 = :)     1 = :(

    v = f(x_0)

    if abs(v) < epsilon
        return r, v, it, err
    end

    x_1 = x_0 - (v/pf(x_0))
    v = f(x_1)
    it = it + 1

    while abs(x_1 - x_0) > delta && abs(v) > epsilon
        if it >= maxit 
            err = 1
            break
        end
        # println(pf(x_0))
        if (pf(x_1) < eps(Float64)) 
            err = 2
        end
        
        it = it + 1
        x_0 = x_1
        x_1 = x_0 - (v/pf(x_0))
        v = f(x_1)
        
        # println(pf(x_0))
    end

    return x_1, v, it, err
end


function test() 
    println(mstycznych(myF, myPf, 100.0, 0.000001, 0.000001, 20))
end
function firstF(x) 
    return (MathConstants.e^(1-x) - 1)
end 

function firstPf(x) 
    return -(MathConstants.e^(1-x))
end 

# println(mstycznych(firstF, firstPf, 8.0, 0.00001, 0.00001, 50))
# test()
end