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



local function removeDuplicates(tab)
    local hash = {}
    local res = {}
    --removes duplicates and creates answer table
    for _,v in ipairs(tab) do
       if (not hash[v]) then
           res[#res+1] = v 
           hash[v] = true
       end
    end
    table.sort(res)
    return res
end
c=union(a,b)
unionAnswer=removeDuplicates(c)
table.insert(unionAnswer,1,'{')
table.insert(unionAnswer,#unionAnswer+1,'}')

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


function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end
displayAns=toCSV(unionAnswer)
make_failure_result_with_error = function(message,pts)
    local onedetail = {seqnum=1,success=false,value=0,max_points=pts}
    local details = {}
    details[message] = onedetail
    return {success=false,value=0, details=details}
    end

set_equality = function(wl)
  return function(b,pts)
    b = string.gsub(b,"^%s*(.-)%s*$", "%1")
    if string.sub(b,1,1) ~= '{' or string.sub(b,#b) ~= '}' then
      name = "Used curly braces"
      return make_failure_result_with_error("Used curly braces",pts)
    end
    b = string.sub(b,2,#b-1)
    local blist = {}
    while b ~= '' do
      local superword = string.match(b,"^%s*[%a%d]+%s*,?%s*")
      local word = string.match(superword,"^%s*([%a%d]+)%s*,?%s*")
      local sep = string.match(superword,"^%s*[%a%d]+%s*(,?)%s*")
      table.insert(blist,word)
      b = string.sub(b,superword:len()+1)
      print("superword: "..superword..">end")
      print("word: "..word..">end")
      print("sep: "..sep..">end")
      print("b: "..b..">end")
      if sep ~= ',' and b ~= '' then
        return make_failure_result_with_error("Used commas properly",pts)
      end
    end
    if #wl ~= #blist then 
      return make_failure_result_with_error("Correct number of values",pts)
    else
      for i=1,#wl do
        local isGood=false
        for j=1,#wl do
        if string.upper(wl[i]) == string.upper(blist[j]) then
            isGood=true
        end
        end
        if not isGood then
          return make_failure_result_with_error("Matched values correctly",pts)
        end
      end
    end
    return {success=true,value=pts}
  end
end