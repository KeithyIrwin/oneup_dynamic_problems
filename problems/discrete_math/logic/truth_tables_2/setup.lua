values = {
    [1] = function (x) a="P" b="Q" c="P" d="Q"end,
    [2] = function (x)a="P" b="Q" c="Q" d="P" end,
    [3] = function (x) a="Q" b="P" c="P" d="Q" end,
    [4] = function (x) a="Q" b="P" c="Q" d="P" end,
  }
  
  answer = {
    [1] = function (x) truthTable={'T','F','T','T'}end,
    [2] = function (x) truthTable={'T','T','F','T'} end,
    [3] = function (x) truthTable={'T','F','T','T'} end,
    [4] = function (x) truthTable={'T','T','F','T'}end,
  }
  
  local case=math.random(1,4)
  
  values[case](x)
  answer[case](x)
  
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
  displayAns=toCSV(truthTable)
  
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