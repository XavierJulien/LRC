# -*- coding: utf-8 -*-
"""

Dictionnaires décrivants les transposés et symétries de relations, 
ainsi que les listes de relations obtenues avec les compositions de base
dans le tableau donné en TD

"""

# transpose : dict[str:str]
transpose = {
    '<':'>',
    '>':'<',
    'e':'et',
    's':'st',
    'et':'e',
    'st':'s',
    'd':'dt',
    'm':'mt',
    'dt':'d',
    'mt':'m',
    'o':'ot',
    'ot':'o',
    '=':'='                 
    }

# symetrie : dict[str:str]
symetrie = {
    '<':'>',
    '>':'<',
    'e':'s',
    's':'e',
    'et':'st',
    'st':'et',
    'd':'d',
    'm':'mt',
    'dt':'dt',
    'mt':'m',
    'o':'ot',
    'ot':'o',
    '=':'='
    }            

# compositionBase : dict[tuple[str,str]:set[str]]             
compositionBase = {        
        ('<','<'):{'<'},
        ('<','m'):{'<'},
        ('<','o'):{'<'},
        ('<','et'):{'<'},
        ('<','s'):{'<'},
        ('<','d'):{'<','m','o','s','d'},
        ('<','dt'):{'<'},
        ('<','e'):{'<','m','o','s','d'},
        ('<','st'):{'<'},
        ('<','ot'):{'<','m','o','s','d'},
        ('<','mt'):{'<','m','o','s','d'},
        ('<','>'):{'<','>','m','mt','o','ot','e','et','s','st','d','dt','='},
        ('m','m'):{'<'},
        ('m','o'):{'<'},
        ('m','et'):{'<'},
        ('m','s'):{'m'},
        ('m','d'):{'o','s','d'},
        ('m','dt'):{'<'},
        ('m','e'):{'o','s','d'},
        ('m','st'):{'m'},
        ('m','ot'):{'o','s','d'},
        ('m','mt'):{'e','et','='},
        ('o','o'):{'<','m','o'},
        ('o','et'):{'<','m','o'},
        ('o','s'):{'o'},
        ('o','d'):{'o','s','d'},
        ('o','dt'):{'<','m','o','et','dt'},
        ('o','e'):{'o','s','d'},
        ('o','st'):{'o','et','dt'},
        ('o','ot'):{'o','ot','e','et','d','dt','st','s','='},
        ('s','et'):{'<','m','o'},
        ('s','s'):{'s'},
        ('s','d'):{'d'},
        ('s','dt'):{'<','m','o','et','dt'},
        ('s','e'):{'d'},
        ('s','st'):{'s','st','='},
        ('et','s'):{'o'},
        ('et','d'):{'o','s','d'},
        ('et','dt'):{'dt'},
        ('et','e'):{'e','et','='},
        ('d','d'):{'d'},
        ('d','dt'):{'<','>','m','mt','o','ot','e','et','s','st','d','dt','='},
        ('dt','d'):{'o','ot','e','et','d','dt','st','s','='}
                           
                   }

def transposeSet(S):
    newS = set();
    for i in S:
        newS.add(transpose[i])
    return newS


def symetrieSet(S):
    newS = set();
    for i in S:
        newS.add(symetrie[i])
    return newS

def composition(r1, r2):
    if(r1 == "="):
        return compositionBase[(r2,r2)]
    elif(r2 == "="):
        return compositionBase[(r1,r1)]
    else:
        return compositionBase[(r1,r2)]
    
def compose(r1, r2):
    if(r1=="=" or r2=="="):
        return composition(r1,r2);
    #def variables
    res = set();
    transR1 = transpose[r1]
    transR2 = transpose[r2]
    symR1 = symetrie[r1]
    symR2 = symetrie[r2]
    twiceR1 = transpose[symetrie[r1]]
    twiceR2 = transpose[symetrie[r2]]
    if((r1,r2) in compositionBase.keys()): #passage direct
        return compositionBase[(r1,r2)]
    elif((transR2,transR1) in compositionBase.keys()): #passage transposée
        res = compositionBase[(transR2,transR1)]
        return transposeSet(res)
    elif((symR1,symR2) in compositionBase.keys()): #passage symétrie
        res = compositionBase[(symR1,symR2)]
        return symetrieSet(res)
    elif((twiceR2,twiceR1) in compositionBase.keys()): # passage complet
        res = compositionBase[(twiceR2,twiceR1)]
        return symetrieSet(transposeSet(res))
        
def compositionSet(S1, S2):
    newS = set();
    for i in S1:
        for j in S2:
            newS = newS|compose(i,j)
    return newS;

class Graphe : 
    def __init__(self, noeuds, relations) : 
        self.noeuds = noeuds
        self.relations = relations

    def getRelations(self,i,j):
        if((i,j) in self.relations.keys()) :
            return self.relations[i,j]
        else : 
            return dict()
    
    def propager(self):
        return 2
    
test = Graphe({"a","b"},{("a","b"):{'<','z'}})
print(test.getRelations("a","b"))
print(test.propager())
    
    
