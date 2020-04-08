-- Re-implementing lists in Lua

-- This could be done with a normal dictionary table seeing 
-- as dictionaries use the same principals as Java lists
-- only more efficiently

letters = {'A', 'B', 'C', 'D', 'E'}
operations = {'add', 'addSpef'}
local opCount = 3 -- Number of list operations to be performed

function problem2 ()
    local list = {}
    local ops = {}

    for i=1,3 do
        local letter = letters[math.random(1,#letters)]
        table.insert(list, letter)
        ops['add' .. tostring(i-1)] = letter            
    end

    local i=1

    while i <= 5 and opCount <= 6 do  
        local operation = operations[math.random(1, #operations)]

        if operation == "add" then
            local letter = letters[math.random(1, #letters)]
            ops[operation .. tostring(i+2)] = letter            
            table.insert(list, letter)
            opCount = opCount + 1
            i = i + 1
            

        elseif operation == "remove" then
            --Makes sure we don't remove from an empty list
            if #list == 1 then
                table.remove(ops, #ops) --Get rid of the op
                i = i-1
                break
            end

            local number = math.random(1, #list)
            ops[operation .. tostring(i+2)] = number            
            table.remove(list, number)
            opCount = opCount + 1
            i = i + 1
            
            

        elseif operation == "addSpef" then
            local letter = letters[math.random(1, #letters)]
            local postion = math.random(1, #list)
            while postion == #letters do
                postion = math.random(1, #list)
            end

            ops[operation .. tostring(i+2)] = {postion, letter} --Keeps track of what has been inserted and what do did it
            table.insert(list, postion, letter)
            opCount = opCount + 1 
            i = i + 1
            
            


        elseif operation == 'replace' then
            local letter = letters[math.random(1, #letters)]
            local postion = math.random(1, #list)

            ops[operation .. tostring(i+2)] = {postion, letter} --Keeps track of what has been removed and what do did it
            table.insert(list, postion, letter)
            table.remove(list, postion+1)
            opCount = opCount + 1 
            i = i + 1
            
            

        end

    end


    return list,ops
end

toString = function(obj)
    string = ''
    for i=1, #obj do
        string = string .. i ..') '..tostring(obj[i]) .. '\n'
    end

    return string

end

function makeQuestion(obj)
    Question = ''
    order =  {'', '', '', '', '', '', ''}
    for k,v in pairs(obj) do
         order[tonumber(string.sub( k, -1 )+1)] = k 
    end


    toString(order)
    for i=1,#order do
        if order[i]:sub(1,-2) == 'addSpef' then
            local num = obj[order[i]][1]
            local letter = obj[order[i]][2]

            Question =  Question .. 'myList.add(' .. tostring(num) ..','.. letter .. ')\n<br/>'
        else if order[i]:sub(1,-2) == 'replace' then
            local num = obj[order[i]][1]
            local letter = obj[order[i]][2]
            Question = Question ..'myList.replace(' .. tostring(num) ..',' .. letter .. ')\n<br/>'     
        else
            Question = Question ..'myList.' .. order[i]:sub(1, -2) ..'('.. obj[order[i]] .. ')\n<br/>'
            i = i
        end
    end
end
end
    

--p2List, p2Ops = problem2()
--toString(p2List)
--makeQuestion(p2Ops)

p2List, p2Ops = problem2()
makeQuestion(p2Ops)

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
displayAns=toCSV(p2List)
word_list_equality = function(wl)
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
      for i,v in ipairs(wl) do
        if string.upper(v) ~= string.upper(blist[i]) then
          return {success=false,value=0}
        end
      end
    end
    return {success=true,value=pts}
  end
end
