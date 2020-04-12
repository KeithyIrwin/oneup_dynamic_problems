primes={2, 3, 5, 7, 11, 13, 17, 19, 23, 29}
r1=table.remove(primes,math.random(1,10))
r2=table.remove(primes,math.random(1,10))
bound=math.random(100,600)

--[[
-- ensures r1 and r2 differ
while r2==r1 do
    r2=math.random(1,9)
end
--ensures the smallest number is displayed first to the student
if r1 > r2 then
    local x=r2
    r2=r1
    r1=x
end--]]

--executes probability formula
divByR1=math.floor(bound/r1)
divByR2=math.floor(bound/r2)
product=r1*r2
divByR1R2=math.floor(bound/product)
--calculates numerator of final probability fraction
numerator=divByR1+divByR2-divByR1R2

ans=numerator/bound