--edit ranges here if desired
r1=math.random(6,15)
r2=math.random(2,9)
r3=math.random(-5,5)

function summation(k,x,y)
    if k == 0 then
        return y
    else 
        return (x*k+y) + summation(k-1,x,y)
    end
end

ans=summation(r1,r2,r3)