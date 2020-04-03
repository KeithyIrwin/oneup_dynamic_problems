node = {
    left = {},
    right = {},
    value = '',
    postion = 0,

    copy = function (self)
        local t2 = {}
        for k,v in pairs(self) do
            t2[k] = v
        end

        t2.list = {}
        return t2
    end
}

--Function to make the tree
function makeTree( )
    -- create tree and root
    tree = {}
    local root = node:copy()
--set root
    root.value = table.remove(letters, math.random(1, #letters))
    tree[1] = root
-- create local variables for loop conditions
    local counter=1
    local initialNumberOfLetters=#letters
   
    while counter<=initialNumberOfLetters do
--select a random tree node and set as root
        root = tree[math.random(counter)]
--check if selected node has room for child nodes, if so creates leaf and increments counter
        if root.left['value'] == nil or root.right['value'] == nil then 
            leaf = node:copy()
            leaf.value = table.remove(letters, math.random(1, #letters))
            counter=counter+1
--randomly selects either left or right child to assign the leaf, if one is already filled leaf is assigned to the other
            if math.random(1,2) == 1 and root.right['value'] == nil then
                root.right = leaf
                tree[counter] = leaf
            elseif root.left['value'] == nil then
                root.left = leaf
                tree[counter] = leaf
            else
                root.right = leaf
                tree[counter] = leaf
            end
        end
    end
end
    
    --[[Make the first three Nodes and link them togther
    firtNode = node:copy() 
    firtNode.value = table.remove( letters, (math.random(1, #letters)) )
    firtNode.postion = 1
    tree[1] = firtNode

    leftLeaf = node:copy()
    leftLeaf.value = table.remove( letters, (math.random(1, #letters)) )
    leftLeaf.postion = 2
    firtNode.left = leftLeaf
    tree[2] = leftLeaf

    rightLeaf = node:copy()
    rightLeaf.value = table.remove( letters, (math.random(1, #letters)) )
    rightLeaf.postion = 3
    firtNode.right = rightLeaf
    tree[3] = rightLeaf
      

    firtNode = leftLeaf
    for i=1,#letters-1 do
        --Means its an even number and we want to link it to the left
        if i%2 == 0 then
            left = node:copy()
            left.value = table.remove( letters, (math.random(1, #letters)) )
            left.postion = i+3
            firtNode.left = left
            tree[i+3] = left
            
        else --Odd so add to the right
            right = node:copy()
            right.value = table.remove( letters, (math.random(1, #letters)) )
            right.postion = i+3
            firtNode.right = right
            tree[i+3] = right
        end
        
        if i == 2 then
            firtNode = rightLeaf
        end
        
    end

    firtNode = tree[4]
    left = node:copy()
    left.value = table.remove( letters, (math.random(1, #letters)) )
    left.postion = 8
    firtNode.left = left
    tree[8] = left
end]]

function preOrder(node)
    if(node.value ~= None) then
        table.insert( preOrderAnswer, node.value )
        answer = answer .. ' ' .. node.value
        preOrder(node.left)
        preOrder(node.right)
    end  
end

function inOrder(node)
    if (node.value ~=None) then
       inOrder(node.left)
       table.insert( inOrderAnswer, node.value )
       inOrder(node.right)
    end
end

function postOrder(node)
    if (node.value ~=None) then
       postOrder(node.left)
       postOrder(node.right)
       table.insert( postOrderAnswer, node.value )
    end
end

function makeGraph()
    for i=1,#tree do
        currentNode = tree[i]
        if currentNode.left['value'] ~= nil or currentNode.right['value'] ~= nil then
            if currentNode.left['value'] ~= nil then
                graphString = graphString .. currentNode['value'] ..'->'.. tree[i].left['value'] .. '; '
            else 
                graphString = graphString .. currentNode['value'] .. 'invisleft [label="X", style=invis ]; '
                graphString = graphString .. currentNode['value'] .. '->'..currentNode['value']..'invisleft [style=invis]; '
            end
            graphString = graphString .. currentNode['value']..'mid [label="X",style=invis]; '
            graphString = graphString .. currentNode['value']..' -> '..currentNode['value']..'mid [style=invis]; '
            if currentNode.right['value'] ~= nil then
                graphString = graphString .. currentNode['value'] ..'->'.. tree[i].right['value'] .. '; '
            else
                graphString = graphString .. currentNode['value'] .. 'invisright [label="X", style=invis ]; '
                graphString = graphString .. currentNode['value'] .. '->'..currentNode['value']..'invisright [style=invis]; '
            end
        end
    end
end




--Fuction to find answer for prombles
letters = {'A', 'B','C', 'D', 'E', 'F', 'G', 'H'}
makeTree()

graphString = 'digraph G { '
makeGraph()
graphString = graphString .. '}'

postOrderAnswer = {};
answer = ''
js = '<script src="/static/ThirdParty/viz.js/viz-lite.js"></script>'
js = js .. '<div id="graph3" s></div><script>x=document.getElementById("graph3");x.innerHTML = Viz(\''..graphString..'\');</script>';
postOrder(tree[1])


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

