r = {}
num={
   [1]='a',
   [2]='b',
   [3]='c',
   [4]='d'
}
let={
     ['a']=1,
     ['b']=2,
     ['c']=3,
     ['d']=4
     
}
--helps the make_subsets function ensure that pairs aren't repeated in the set creation
function tableContains(tab,element)
 for k in pairs(tab) do
   if k == element then
     return true
   end
 end
 return false
end
--creates the initial set randomly with a random amount of ordered pairs
function make_subsets ()
   local res = {}
   local count = 0
   x=math.random(7,9)
   while count < x do
       local y=num[math.random(1,4)]..num[math.random(1,4)]
       if not tableContains(res,y) then
           res[y]=true
           count=count+1
       end
   end
   return res
end
--ensures the given set is of a reflexive relation, if the set isn't already
function make_reflexive(tab)
    local res = {}
    for k in pairs(tab) do
       if not tab[string.sub(k,1,1)..string.sub(k,1,1)]  then
           res[string.sub(k,1,1)..string.sub(k,1,1)]=true
       end
       if not tab[string.sub(k,2,2)..string.sub(k,2,2)] then
           res[string.sub(k,2,2)..string.sub(k,2,2)]=true
       end
   end
   for k in pairs(tab)do
     res[k]=true
   end
   return res

end
--checks for reflexive relation
function is_reflexive (tab)
    for k in pairs(tab) do
       if not tab[string.sub(k,1,1)..string.sub(k,1,1)]  then
           return false
       end
       if not tab[string.sub(k,2,2)..string.sub(k,2,2)] then
           return false
       end
   end
   return true

end
--checks for symmetric relation
function is_symmetric (tab)
   for k in pairs(tab) do
       if not tab[string.sub(k,2,2)..string.sub(k,1,1)] then
           return false
       end
   end
   return true
end
--ensures set is of a symmetric relation
function make_symmetric (tab)
   local res={}
   for k in pairs(tab) do
       
       if not tab[string.sub(k,2,2)..string.sub(k,1,1)] then
           res[string.sub(k,2,2)..string.sub(k,1,1)]=true
       end
   end
   for k in pairs(tab)do
     res[k]=true
   end
   return res
end

function is_antisymmetric (tab)
   isGood=false
   for k in pairs(tab) do
     if string.sub(k,1,1) ~= string.sub(k,2,2) then
       if  tab[string.sub(k,2,2)..string.sub(k,1,1)] then
           return false
       end
     end
   end
   return true
end
function make_antisymmetric (tab)
   local res={}
   for k in pairs(tab)do
     res[k]=true
   end
   for k in pairs(tab) do
     if string.sub(k,1,1) ~= string.sub(k,2,2) then  
       if tab[string.sub(k,2,2)..string.sub(k,1,1)] then
           res[string.sub(k,2,2)..string.sub(k,1,1)]=nil
       end
     end
   end
   
   return res  
end
function make_transitive (tab)
   local res = {}
   for i in pairs(tab) do
       local x = string.sub(i,1,1)
       local y = string.sub(i,2,2)
       for j in pairs(tab) do
           if string.sub(j,1,1) == y then 
               local z = string.sub(j,2,2)
               
               if not tab[x..z] then
                   res[x..z] = true
               end
           end
       end
   end
   for k in pairs(tab)do
     res[k]=true
   end
   return res
end
function is_transitive(tab)
   for i in pairs(tab) do
       local x = string.sub(i,1,1)
       local y = string.sub(i,2,2)
       for j in pairs(tab) do
           if string.sub(j,1,1) == y then 
               local z = string.sub(j,2,2)
               if not tab[x..z] then
                   return false
               end
           end
       end
   end
   return true
end
--function prints the ordered pairs in the set
function print_set(tab)
    local s = ''
     for k in pairs(tab) do
         
         s = s..'('..let[string.sub(k,1,1)]..','..let[string.sub(k,2,2)]..'),'
     end
     s = s:sub(1, -2)
   return s
end

function roll_relation(tab)
    local roll = math.random(1,4)
    
    if roll == 1 then 
       tab=make_reflexive(tab)
    elseif roll == 2 then
        tab=make_symmetric(tab)
    elseif roll == 3 then
        tab=make_antisymmetric(tab)
    else
        while not is_transitive(tab) do
            tab=make_transitive(tab)
        end
    end
    
   return tab
end

function set_answers(tab)
   transitiveAnswer=''
   reflexiveAnswer=''
   symmetricAnswer=''
   antisymmetricAnswer=''
   if is_transitive(tab) then
       transitiveAnswer='T'
   else
       transitiveAnswer='F'
   end
   if is_reflexive(tab) then
       reflexiveAnswer='T'
   else
       reflexiveAnswer='F'
   end
   if is_symmetric(tab) then
       symmetricAnswer='T'
   else
       symmetricAnswer='F'
   end
   if is_antisymmetric(tab) then
       antisymmetricAnswer='T'
   else
       antisymmetricAnswer='F'
   end
    
end



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


r=make_subsets()
r=roll_relation(r)
set_answers(r)


display=print_set(r)