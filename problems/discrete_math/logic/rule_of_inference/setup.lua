rules = {
    ['k1']={str='If there is fire, there is smoke. There is no smoke. Therefore there is no fire.',
        type='modus tollens',
        num=1
    },
    ['k2']={str='If John is happy, he smiles. John is not smiling. Therefore John is not happy.',
        type='modus tollens',
        num=1
    },
    ['k3']={str='If it is raining, the sky is cloudy. The sky is not cloudy. Therefore it is not raining.',
        type='modus tollens',
        num=1
    },
    ['k4']={str='If Don is a chicken, then he is a bird. Don is a chicken. Therefore Don is a bird.',
        type='modus ponens',
        num=2
    },
    ['k5']={str='If it is Friday, class will be released early. It is Friday. Therefore class will be released early.',
        type='modus ponens',
         num=2
    },
    ['k6']={str='If Mary is an excellent swimmer, Mary can work as a lifeguard. Mary is an excellent swimmer. Therefore Mary can work as a lifeguard.',
        type='modus ponens',
         num=2
    },
    ['k7']={str='If I do not wake up, then I cannot go to work.If I cannot go to work, then I will not get paid. Therefore, if I do not wake up, then I will not get paid.',
        type='hypothetical syllogism',
        num=3
    },
    ['k8']={str="If it rains, we will not have a picnic. If we don't have a picnic, we won't need a picnic basket. Therefore, if it rains, we won't need a picnic basket.",
        type='hypothetical syllogism',
        num=3
    },
    ['k9']={str='If you study logic, then you will understand logic. If you understand logic then you will pass the course. Therefore, if you study logic you will pass the course',
        type='hypothetical syllogism',
        num=3
    },
    ['k10']={str='The apple is red or green. The apple is not red. Therefore, the apple is green.',
        type='disjunctive syllogism',
        num=4
    },
    ['k11']={str='I will eat steak or I will eat fish. I will not eat fish. Therefore, I will eat steak.',
        type='disjunctive syllogism',
        num=4
    },
    ['k12']={str='The Sun orbits the Earth or the Earth orbits the Sun. The Sun does not orbit the Earth. Therefore, the Earth orbits the Sun.',
        type='disjunctive syllogism',
        num=4
    }
}

function getKeys(tab)
    local res={}
    local n=0
    
    for k in pairs(tab) do
        n=n+1
        res[n] = k
        
    end
    
    return res
end

keyset=getKeys(rules)

key = keyset[math.random(1,#keyset)]

display = rules[key].str
ans = rules[key].num