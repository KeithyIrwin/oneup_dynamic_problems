coins = math.random(20,40)
differentCoins = 4
--recursive function for calculating combination factorials
function factorial(n)
    if (n == 0) then
        return 1
    else
        return n * factorial(n - 1)
    end
end
--executes formula C(n+r-1,r) where n is the different kinds of coins and r is the total number of coins
facNumerator = coins+differentCoins-1
ans = factorial(facNumerator)/(factorial(coins)*factorial(facNumerator-coins))