using Printf

import Base:+,-,*,/

abstract type AbstractDual end

struct Dual{T <: Number} <: AbstractDual
    val::T
    der::T
end

Variable(a::Number) = Dual(a, 1.)
Constant(a::Number) = Dual(a, 0.)

a::AbstractDual + b::AbstractDual = Dual(a.val + b.val, a.der + b. der)
a::AbstractDual + b::Number = a + Constant(b)
a::Number + b::AbstractDual = b + a

a::AbstractDual - b::AbstractDual = Dual(a.val - b.val, a.der - b. der)
a::AbstractDual - b::Number = a - Constant(b)
a::Number - b::AbstractDual = Constant(a) - b

a::AbstractDual * b::AbstractDual = Dual(a.val * b.val, a.der * b.val + a.val * b.der)
a::AbstractDual * b::Number = a * Constant(b)
a::Number * b::AbstractDual = b * a

a::AbstractDual / b::AbstractDual = Dual(a.val / b.val, (a.der * b.val - a.val * b.der) / (b.val * b.val))
a::AbstractDual / b::Number = a / Constant(b)
a::Number / b::AbstractDual = Constant(a) / b


const x = Variable(1.)

@printf("x \t\t= \t%s\n", x)
@printf("x^2 \t\t= \t%s\n", x * x)
@printf("x^2 - 3x + 2 \t= \t%s\n", x * x - 3. * x + 2.)
