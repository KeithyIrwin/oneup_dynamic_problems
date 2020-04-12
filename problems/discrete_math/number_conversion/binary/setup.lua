r1 = math.random(100,999) 

function toBinary(num)
    local t={} -- will contain the bits
    while num>0 do
        rest=math.fmod(num,2)
        t[#t+1]=rest
        num=(num-rest)/2
    end
    return t
end
bits=toBinary(r1)
ans=''
--converts bit table to a string
for i=1, #bits do
    ans=bits[i]..ans
end
--converts to integer for answer check
ans=tonumber(ans)