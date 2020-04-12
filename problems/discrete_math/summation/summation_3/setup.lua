--edit ranges here if desired
r1=math.random(4,8)
r2=math.random(2,9)
r3=math.random(2,9)

function summation(k,x,y)
    if k == 0 then
        return 2
    else 
        return (x^k+(-y)^k) + summation(k-1,x,y)
    end
end

ans=summation(r1,r2,r3)