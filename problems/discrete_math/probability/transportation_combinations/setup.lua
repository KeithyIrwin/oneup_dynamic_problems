transportations={'bus','car','truck','scooter','bike','subway','cab','motorcycle'}
transportationString=''
numberOfTransportation=math.random(4,#transportations)

for count=1,numberOfTransportation do
    
    if count==numberOfTransportation then
        transportationString=transportationString.." and "..transportations[count].."."
        
    
    else 
        transportationString=transportationString..transportations[count]..", "
    end
end