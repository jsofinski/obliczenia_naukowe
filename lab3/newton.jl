# autor: Jakub Sofiński
module Newton
export mstycznych

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

    while abs(x_1 - x_0) > delta && abs(v) > epsilon && it < maxit
        it = it + 1

        x_0 = x_1
        x_1 = x_0 - (v/pf(x_0))
        v = f(x_1)
    end

    return x_1, v, it, err
end

# println(mstycznych(myF, myPf, 15.0, 0.000001, 0.000001, 20))

end