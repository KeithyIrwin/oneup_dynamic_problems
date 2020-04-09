
numOfOps = 3
pushCount = 3
popCount = 0
peakCount = 0
numStatements = 20 -- @default: 20

Queue = {
            list = {},
            length = 0,

            enqueue = function(self, value)
                        --Adds values into the Queue
                        table.insert(self.list, value)
                        self.length = self.length + 1
                    end,

            dequeue = function(self)
                    --removes last element in list returns nill if no one is in list
                    removeValue = self.list[1]
                    table.remove(self.list, 1 )
                    self.length = self.length - 1
                    return removeValue
                end,

            peak = function(self)
                    -- returns value at the front of stack returns nil if its empty
                    return self.list[1]
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
                for i=1, #self.list, 1 do
                    string = string .. i ..') '..tostring(self.list[i]) .. '\n'
                end

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


names = {'Jane', 'Jess', 'Jill', 'Jim','Jamal'}
operations = {'enqueue' ,'dequeue', 'peak'} -- Vestigial Table

function question3(qname) --IF the length is >= 2 do all else either end at least six functions and none
    q3Queue = Queue:copy()

    local opsoutput = ""
    --Add the first three entries
    for i=1,math.random(3,5)do
        local name = names[math.random(#names)]
        q3Queue:enqueue(name)
        opsoutput = opsoutput .. qname .. ".enqueue("..name..");<BR>\n"
    end

    actions = { --Sort of like a switch statement
        [1] = function (x) q3Queue:enqueue(x) end,
        [2] = function (x) q3Queue:dequeue() end,
        [3] = function (x) q3Queue:peak() end,
        [4] = function (x) q3Queue:enqueue(q3Queue:dequeue()) end,--push pop
        [5] = function (x) q3Queue:enqueue(q3Queue:peak()) end,--push peak

    }

    for i=0,numStatements do  -- the number of statements to be displayed over the initial 3 additions
        --print(q3Stack.length)

        case = math.random(#actions) --get random actions

        --print(case)

        if(q3Queue.length > 2 and numOfOps < 10) then  -- a cap for the number of displayed statements
            numOfOps = numOfOps+1

            if(case == 1) then
                pushCount = pushCount+1
		            local name = names[math.random(#names)]
                if(pushCount <= 5) then --Max is 5 push
                    actions[1](name)
                    opsoutput = opsoutput .. qname .. ".enqueue("..name..");<BR>\n"
                else
                    i = i-1
                end
   

            elseif (case == 2) then
                popCount = popCount+1
                actions[2]()

                if(q3Queue:isEmpty()) then --If the list is empty add someone to the list
                   actions[1](name)
                end

		        if popCount + peakCount == 1 then 
			               opsoutput = opsoutput .. "String "
				               end
			        opsoutput = opsoutput .. "name = "..qname..".dequeue();<BR>\n"

            elseif(case == 3) then
                peakCount = peakCount+1
                actions[3]()

		        if popCount + peakCount == 1 then 
			               opsoutput = opsoutput .. "String "
				               end

			        opsoutput = opsoutput .. "name = "..qname .. ".getFront();<BR>\n"

            elseif(case == 4) then
                actions[4]()
		        opsoutput = opsoutput .. qname..".enqueue("..qname..".dequeue());<BR>\n"

            elseif(case == 5) then
                pushCount = pushCount+1
                if(pushCount <= 5) then --Max is 5 push
                    actions[1](name)
                else
                    i = i-1
                end

                actions[5]()
		opsoutput = opsoutput .. qname..".enqueue("..qname..".getFront());<BR>\n"
            end
        end

    end

    return q3Queue.list, opsoutput

end

answer,opslist = question3("myqueue")
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
displayAns=toCSV(answer)
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
