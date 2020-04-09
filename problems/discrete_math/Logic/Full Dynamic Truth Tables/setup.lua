node = {
    parent = nil,
    left = nil,
    right = nil,
    value = '',
    position = 0,
    varType='',

    copy = function (self)
        local t2 = {}
        for k,v in pairs(self) do
            t2[k] = v
        end

        t2.list = {}
        return t2
    end
}
operands = {'P','Q','R'}
-- list of dicts for the operators and their properties
operators = {
             {symbol='¬',
                associative=true,
                ary=1,
                precedence=1,
                frequency=2,
                funct=function(x) return not x end
            },
             {
                symbol='∨',
                associative=true,
                ary=2,
                precedence=4,
                frequency=1,
                funct=function(x,y) e=child1 w=child2 return (x or y) end
                },
                {
                symbol='∧',
                associative=true,
                ary=2,
                precedence=2,
                frequency=1,
                funct=function(x,y) return (x and y) end
                },
                 {
                symbol='⊻',
                associative=true,
                ary=2,
                precedence=3,
                frequency=1,
                funct=function(x,y) return (x or y) and not(x and y)end
                },
                 {
                symbol='→',
                associative=false,
                ary=2,
                precedence=5,
                frequency=1,
                funct=function(x,y) return not x or y end
                },
                 {
                symbol='↔',
                associative=true,
                ary=2,
                precedence=6,
                frequency=1,
                funct=function(x,y) return not ((x or y) and not(x and y)) end
                }
}
--Function to get operands
function getAtom(tab)
    res=operands[math.random(1,#operands)]
    return res
end
--Function to get operators with weighted values
function getOperator(tab)
    local val = math.random(1,#tab)
    local freq = 0
    local count = 0
    while freq <= val do
        count = count + 1
        freq = freq+tab[count].frequency
        
    end
    return tab[count]
end
--creates the tree to be used for the truth table
function makeTree(n)
    
    local count = 0
    leafNodes={}
    local root=node:copy()
    root.value=getAtom(operands)
    root.varType='atom'
    leafNodes[1]=root
    
    while count < n do 
        
        lf=leafNodes[math.random(1,#leafNodes)]
        p=lf.parent
        
        newOp=getOperator(operators)
        newNode = {left=lf, value=newOp,varType='op',parent=p}
        if lf == root then
          root=newNode
        end
      
        if newOp.ary==2 then
            newNode.right={value=getAtom(),parent=newNode,varType='atom'}
        
        end
        if p ~= nil then
          if p.left==lf then 
            
            p.left=newNode 
           
          elseif p.right==lf then
            
            p.right=newNode
          
          end
        end
        lf.parent=newNode
        table.insert(leafNodes,newNode.right)
        
        count=count+1
   
    end
    return root
end 
function nodeToString(node)
  if node==nil then
    return ''
  elseif node.varType=='atom' then
    return node.value
  else
    local startParen = ''
    local endParen = ''
    if node.parent ~= nil then
      
      if node.value.precedence > node.parent.value.precedence or (node.value.precedence == node.parent.value.precedence and node.value.associative==false) then
          startParen = '('
          endParen = ')'
      end
    end
    if node.value.ary==1 then
      return startParen..node.value.symbol..nodeToString(node.left)..endParen
    
        
    else
      return startParen..nodeToString(node.left)..node.value.symbol..nodeToString(node.right)..endParen
    end
  end
end
function eval(node,values)
    
    if node.varType=='atom' then        
        return values[node.value]
   elseif node.varType=='op' then
      if node.left~= nil then
        child1 = eval(node.left,values)
      end
      if node.right ~= nil then
          child2 = eval(node.right,values)
      end
        if node.value.ary==1 then
          
          return node.value.funct(child1)
        else
          
          return node.value.funct(child1,child2)
        end
    end
end
--function checks to prevent duplicates in the leafMap
function tableContains(tab,element)
  for _, value in pairs(tab) do
    if value == element then
      return true
    end
  end
  return false
end
--Creates a map for the leaves and randomizes their boolean value for the question
function setAtoms(tab)
  local res = {}
  for k in pairs(tab) do
     if not tableContains(res,tab[k].value) then
          res[tab[k].value]=false
     end
    for k in pairs(res) do
        local x = math.random(1,2)
        if x < 2 then
          res[k]=true
        else
          res[k]=false
        end
     end
  end
  return res
end
function getAnswer(bool)
    local res = {}
    if bool then 
        table.insert(res,'T')
    else
        table.insert(res,'F')
    end
    return res
    
end



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

--complexity counter for the size of the tree
local n = 3




tree=makeTree(n)
leafMap=setAtoms(leafNodes)

x=eval(tree,leafMap)
answer=getAnswer(x)
    

display=nodeToString(tree)



