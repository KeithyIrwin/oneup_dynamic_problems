--edit ranges here if desired
r1=math.random(3,6)
r2=math.random(5,20)
r3=math.random(2,8)

function summation(k,x,y)
    if k == 0 then
        return x
    else 
        return (x/y^k) + math.ceil(summation(k-1,x,y))
    end
end

ans=math.ceil(summation(r1,r2,r3))