--constructs the initial set based on n # of elements
function getSet(n)
    local res = {}
    for i=1, n do
        res[i]=i   
    end
    table.sort(res)
    return res
end
--separates original set into random partitions
function setPartition(tab,size)
    local res = {}
    for i=1, size do
        item = table.remove(tab,math.random(1,#tab))
        table.insert(res,item)
    end
    table.sort(res)
    return res
end
    
--function prints the set for display
 function print_set(tab)
     local s = ''
      for v in ipairs(tab) do
           s = s..tab[v]..','
      end
      s = s:sub(1, -2)
    return s
 end
 
 function get_answer(t1,t2)
     local res = {}
     for i,v in ipairs(t1) do
         for j,k in ipairs (t1) do
             table.insert(res, v..','..k)
         end
         
     end
     for i,v in ipairs(t2) do
         for j,k in ipairs (t2) do
             table.insert(res, v..','..k)
         end
         
     end
     return res
 end
 
 function print_ans(tab)
     local s = ''
      for v in ipairs(tab) do
        
           s = s..'('..tab[v]..')'
         
      end
     
    return s
 end
 
--generates the number of elements in the set
n=math.random(4,6)
set = getSet(n)

t1set=set
t2set=set

display=print_set(set)

x = math.random(1,n-1)
t1 = setPartition(t1set,x)
t2 = setPartition(t2set,n-x)

p1=print_set(t1)
p2=print_set(t2)
ans=get_answer(t1,t2)
dis=print_ans(ans)


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
displayAns=toCSV(ans)

word_list_unordered_comma_joined_equality = function(wl)
  return function(b,pts)
    local blist = {}
    while b ~= '' do
      local word = string.match(b,"[%a','%d]*")
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