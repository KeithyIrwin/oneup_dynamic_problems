blue=math.random(2,3)
green=math.random(4,7)
totalBalls=green+blue
color=''
if math.random(1,2)%2 == 0 then
    color='green'
else
    color='blue'
end
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end
if color=='green' then
    ans = green/(green+blue)
    ans = round(ans,2)
else
    ans = blue/(green+blue)
    ans = round(ans,2)
end