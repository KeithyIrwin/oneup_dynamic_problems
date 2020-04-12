men = math.random(10,20)
women = math.random(10,20)

totalMembers = men+women
selectMembers = math.random(5,7)

--recursive function for calculating combination factorials
function factorial(n)
    if (n == 0) then
        return 1
    else
        return n * factorial(n - 1)
    end
end

-- executes formula answer=total combinations - (only men+only women combinations)
totalComb = factorial(totalMembers)/(factorial(selectMembers)*factorial(totalMembers-selectMembers))
onlyMen = factorial(men)/(factorial(selectMembers)*factorial(men-selectMembers))
onlyWomen = factorial(women)/(factorial(selectMembers)*factorial(women-selectMembers))

ans = totalComb-onlyMen-onlyWomen