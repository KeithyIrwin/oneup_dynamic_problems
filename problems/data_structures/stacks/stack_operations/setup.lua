--[[
    This is the class like struct for a lua stack push, pop, peak, is empty
    
    v1.0
-- ]]

Config = {
  names = {'Jane', 'Jess', 'Jill', 'Jim', 'Jamal','Javon'};
  -- Names to be used in problem
  numOps = 4;
  -- Number of operations to be executed
}

Stack = {   list = {},
            length = 0, --Keeps track of how big table is Note -1 when used

            push = function (self, value)
                    --Adds a element into the table
                    table.insert(self.list, value)
                    self.length = self.length + 1

                end,

            pop = function(self)
                    --removes last element in list returns nill if no one is in list
                    removeValue = self.list[self.length]
                    table.remove(self.list, self.length )
                    self.length = self.length - 1
                    return removeValue
                end,

            peak = function(self)
                    -- returns value at the front of stack returns nil if its empty
                    return self.list[self.length]
                end,

            isEmpty = function(self)
                if (self.length > 0) then
                        return false
            else
                    return true
                end

            end,

            toString = function(self)
                string = ''
                for i=#self.list, 1, -1 do
                    string = string .. tostring(self.list[i]) .. '\n'
                end

                print(string)
                return string

            end,

            copy = function (self)
                local t2 = {}
                for k,v in pairs(self) do
                    t2[k] = v
                end

                t2.list = {}
                return t2
            end


}

operations = {'push' ,'pop', 'peek'} -- vestigial table

function question3() --IF the length is >= 2 do all else either end at least six functions and none
    q3Stack = Stack:copy()
    numOfOps = 3
    pushCount = 3
    popCount = 0
    peakCount = 0

    local opsOutput = ""

    --Add the first three entries
    for i=1,math.random(3,6) do 
        local name = Config.names[math.random(#Config.names)]
        q3Stack:push(name)
        opsOutput = opsOutput .. 'pile.push("'..name..'");<BR>\n'
    end
    
    actions = { --Sort of like a switch statement
        [1] = function () local name = Config.names[math.random(#Config.names)] q3Stack:push(name) return 'pile.push("'..name..'");<BR>\n' end,
        [2] = function () q3Stack:pop() return 'pile.pop();<BR>\n' end,
        [3] = function () q3Stack:peak() return 'pile.peek();<BR>\n' end,
        [4] = function () q3Stack:push(q3Stack:pop()) return 'pile.push(pile.pop());<BR>\n' end,--push pop
        [5] = function () q3Stack:push(q3Stack:peak()) return 'pile.push(pile.peek());<BR>\n' end,--push peak

    }

    local i = 0
    while i<=Config.numOps-1 do
        i = i+1
        case = math.random(#actions) --get random actions

        if(q3Stack.length > 2 and numOfOps < 10) then
            numOfOps = numOfOps+1

            if(case == 1) then
                pushCount = pushCount+1
                if(pushCount <= 5) then --Max is 5 push
                    opsOutput = opsOutput .. actions[1]()
                else
                    i = i-1
                end
            elseif (case == 2) then
                popCount = popCount+1
                opsOutput = opsOutput .. actions[2]()

                if(q3Stack:isEmpty()) then --If the list is empty add someone to the list
                    opsOutput = opsOutput .. actions[1]()
                    numOfOps = numOfOps+1
                end

            elseif(case == 3) then
                peakCount = peakCount+1
                opsOutput = opsOutput .. actions[3]()

                --print('Peek')
            elseif(case == 4) then
                opsOutput = opsOutput .. actions[4]()

                --print("Push, Pop")
            elseif(case == 5) then
                pushCount = pushCount+1
                if(pushCount <= 5) then --Max is 5 push
                    opsOutput = opsOutput .. actions[1]()
                else
                    i = i-1
                end
                opsOutput = opsOutput .. actions[5]()
            end
        end

    end

    return q3Stack.list, opsOutput

end

result,ops = question3()

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
displayAns=toCSV(result)

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
