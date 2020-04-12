r1 = math.random(100,1000)

function decToHexa(n) 
    local res = {}
    i = 1
    while n~=0 do
        -- storing remainder in temp variable. 
        temp = n % 16 
          
        -- check if temp < 10 
        if temp < 10 then
            res[i] = string.char(temp + 48)
            i=i+1 
         
        else
            res[i] = string.char(temp + 55)
            i=i+1
        end  
        n = math.floor(n/16)
    end 
    return res 
end

hexTable=decToHexa(r1)
ans=''
--converts bit table to a string
for i=1, #hexTable do
    ans=hexTable[i]..ans
end
--[[
string_equality = function(str)
  return function(b,pts)
    
    if string.upper(b)==str then
        return {success=true,value=pts}
    else
        return {success=false,value=0}
   end
  end
end]]--

string_equality_ignore_spaces = function(str)
  return function(b,pts)
    if b == nil then
       return {success=false,value=0}
    end
    local str_no_space = str:gsub("%s*","")
    local b_no_space = b:gsub("%s*","")
    if string.upper(str_no_space) == string.upper(b_no_space) then
      return {success=true,value=pts}
    else
      return {success=false,value=0}
    end
  end
end