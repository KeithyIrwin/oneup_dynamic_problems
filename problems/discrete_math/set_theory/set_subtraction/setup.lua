local a={}
local b={}
local universe = {1,2,3,4,5,6,7,8,9}
aString=''
bString=''
for i=1, 6 do
   
    table.insert(a,table.remove(universe,math.random(1,#universe)))
end -- creates the 2 sets from universe
table.sort(a)

local universe = {1,2,3,4,5,6,7,8,9}
for i=1, 4 do
   
    table.insert(b,table.remove(universe,math.random(1,#universe)))
end
table.sort(b)
    

for k,v in ipairs(a) do  --displays sets to the student
    if k==6 then aString=aString..v
    else aString=aString..v..","
    end
end
for k,v in ipairs(b) do 
    if k==4 then bString=bString..v
    else bString=bString..v..","
    end
end



local function union ( a, b )
    --adds the two tables into one
    local res = {}
    for k,v in pairs ( a ) do
        table.insert( res, v )
    end
    for k,v in pairs ( b ) do
         table.insert( res, v )
    end
    return res
end

local function subtract(a,b)
local hash = {}
local res = {}
--keeps a single copy of duplicates and creates answer table
    for _,v in ipairs(b) do
     hash[v]=true
    end
    for _,v in ipairs(a) do
     if not hash[v] then
       table.insert(res,v)
     end
    end
    table.sort(res)
    return res
end



subtractionAnswer=subtract(a,b)

function escapeCSV (s)
  if string.find(s, '[,"]') then
    s = '"' .. string.gsub(s, '"', '""') .. '"'
  end
  return s
end
--serializes answer table to a comma separated string
function toCSV (tt)
  local s = ""
  for _,p in ipairs(tt) do  
    s = s .. "," .. escapeCSV(p)
  end
  return string.sub(s, 2)      -- remove first comma
end
-- displayAns to be used as last parameter to show a correct answer to the students
displayAns=toCSV(subtractionAnswer)

word_list_unordered_equality = function(wl)
  return function(b,pts)
    local blist = {}
    while b ~= '' do
      local word = string.match(b,"[%a%d]*")
      table.insert(blist,word)
      b = string.sub(b,word:len()+1)
      local sep = string.match(b,"[^%a%d]*")
      b = string.sub(b,sep:len()+1)
    end
    if #wl ~= #blist then 
      return {success=false,value=0}
    else
      for i=1,#wl do
        local isGood=false
        for j=1,#wl do
        if string.upper(wl[i]) == string.upper(blist[j]) then
            isGood=true
        end
        end
        if not isGood then
          return {success=false,value=0}
        end
      end
    end
    return {success=true,value=pts}
  end
end