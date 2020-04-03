--[[
    This is the class like struct for a lua stack push, pop, peak, is empty
-- ]]

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

function makePostFix(question)
    postStatment = {}

    if(question == '5a') then
         table.insert(postStatment, letters[math.random(#letters)])
         table.insert(postStatment, letters[math.random(#letters)])
         table.insert(postStatment, operations[math.random(#operations)])
         table.insert(postStatment, letters[math.random(#letters)])
         table.insert(postStatment, letters[math.random(#letters)])
         table.insert(postStatment, operations[math.random(#operations)])
         table.insert(postStatment, operations[math.random(#operations)])

    elseif (question == '5b') then
        table.insert(postStatment, letters[math.random(#letters)])
        table.insert(postStatment, letters[math.random(#letters)])
        table.insert(postStatment, operations[math.random(#operations)])
        table.insert(postStatment, letters[math.random(#letters)])
        table.insert(postStatment, letters[math.random(#letters)])
        table.insert(postStatment, operations[math.random(#operations)])
        table.insert(postStatment, letters[math.random(#letters)])
        table.insert(postStatment, operations[math.random(#operations)])
        table.insert(postStatment, operations[math.random(#operations)])

    elseif(question == '6a') then
        table.insert(postStatment, letters[math.random(#letters)])
        table.insert(postStatment, letters[math.random(#letters)])
        table.insert(postStatment, letters[math.random(#letters)])
        table.insert(postStatment, operations[math.random(#operations)])
        table.insert(postStatment, operations[math.random(#operations)])

    elseif(question == '6b') then
        table.insert(postStatment, letters[math.random(#letters)])
        table.insert(postStatment, letters[math.random(#letters)])
        table.insert(postStatment, letters[math.random(#letters)])
        table.insert(postStatment, operations[math.random(#operations)])
        table.insert(postStatment, letters[math.random(#letters)])
        table.insert(postStatment, operations[math.random(#operations)])
        table.insert(postStatment, operations[math.random(#operations)])

    end
    return postStatment

end

function question5()
    print('Question 5')

    postStatementA = makePostFix('5a')
    postAnwserA = postStatementA[1]  .. postStatementA[2] .. postStatementA[3] ..
    postStatementA[4] .. postStatementA[5] .. postStatementA[6] .. postStatementA[7]

    infixStatmentA = '(' .. postStatementA[1] .. postStatementA[3] .. postStatementA[2] .. ')' ..
    postStatementA[7] .. '(' .. postStatementA[4] .. postStatementA[6] .. postStatementA[5] .. ')'
    print( 'a) ' .. postAnwserA)
    print('   ' .. infixStatmentA .. '\n')

    postStatementB = makePostFix('5b')
    postAnwserB = postStatementB[1]  .. postStatementB[2] .. postStatementB[3] ..
    postStatementB[4] .. postStatementB[5] .. postStatementB[6] .. postStatementB[7] .. postStatementB[8] .. postStatementB[9]

    infixStatmentB  = '(' .. postStatementB[1] .. postStatementB[3] ..postStatementB[2] .. ')' .. postStatementB[9] .. '((' .. postStatementB[4] .. postStatementB[6] ..
    postStatementB[5] .. ')' .. postStatementB[6] .. postStatementB[7] .. ')'
    print('b) ' .. postAnwserB)
    print('   ' .. infixStatmentB)
end

function calAnswerStack(statement)
    local varStack = Stack:copy()
    local i = 1
    while i <= #statement do
        if statement[i] == 'a' then
            varStack:push(2)
        elseif statement[i] == 'b' then
            varStack:push(3)
        elseif statement[i] == 'c' then
            varStack:push(4)
        elseif statement[i] == 'd' then
            varStack:push(5)
        elseif statement[i] == 'e' then
            varStack:push(6)
        elseif statement[i] == 'f' then
            varStack:push(1)    
        elseif statement[i] == '+' then
            varStack:push(varStack:pop() + varStack:pop())
        elseif statement[i] == '-' then
            y = varStack:pop()
            x = varStack:pop()
            varStack:push(x-y)
        elseif statement[i] == '*' then
            varStack:push(varStack:pop() * varStack:pop())
        elseif statement[i] == '/' then
            y = varStack:pop()
            if y == 0 then
                return false
            end
            x = varStack:pop()
            varStack:push(x/y)
        end
        i = i + 1
    end
    return varStack:pop()
end

function question6()
    --Note that A=2, B=3, C=4, D=5

    postStatementA = makePostFix('6a')
    postFixA = postStatementA[1] .. postStatementA[2] .. postStatementA[3] .. postStatementA[4] .. postStatementA[5]
    postAnwserA = calAnswerStack(postStatementA)
    if(postAnwserA == false) then
        return false
    end


    postStatementB = makePostFix('6b')
    postFixB = postStatementB[1] .. postStatementB[2] .. postStatementB[3] .. postStatementB[4] .. postStatementB[5]
    .. postStatementB[6] .. postStatementB[7]
    postAnwserB = calAnswerStack(postStatementB)
    if(postAnwserB == false) then
        return false
    end

    return true

end



operations = {'+', '-', '/', '*'}
letters = {'a', 'b', 'c', 'd','e','f'}

while  not question6() do

end
