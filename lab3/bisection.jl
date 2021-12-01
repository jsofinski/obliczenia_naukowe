# autor: Jakub Sofiński
module Bisection
export mbisekcji

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

#                  f  left        right       accuracy        macheps
function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64) 
    r::Float64 = 0.0    # x_0
    v::Float64 = 0.0    # f(x_0)
    it = 0              # number of iterations
    err = 0             # 0 = :)     1 = :(

    left = f(a)
    right = f(b)
    e = b - a
    r = a + e
    v = f(r)

    if sgn(left) == sgn(right)
        err = 1
        return r, v, it, err
    end

    while e > delta && abs(v) > epsilon
        it = it + 1
        e = e/2.0
        r = a + e
        v = f(r)

        if (sgn(left) != sgn(v))
            b = r
            right = v
        else
            a = r
            left = v
        end
        # println(it)
    end

    return r, v, it, err
end

function test() 
    println(mbisekcji(myF, 0.0, 2.0, 0.000001, 0.000001))
    println(mbisekcji(myF, 0.0, 2.1, 0.000001, 0.000001))
end

# test()

end