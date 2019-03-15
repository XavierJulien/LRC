module TME4hexa

where
import Data.List
import DEMO_S5

-- les agents sont a,b,c
-- les cartes sont les caracteres r,v,j

allHands = [('r','v','j'),('r','j','v'),('j','r','v'),('j','v','r'),('v','r','j'),('v','j','r')]
rela = (a,[[('r','v','j'),('r','j','v')],[('j','r','v'),('j','v','r')],[('v','r','j'),('v','j','r')]])
relb = (b,[[('r','v','j'),('j','v','r')],[('r','j','v'),('v','j','r')],[('v','r','j'),('j','r','v')]])
relc = (c,[[('r','v','j'),('v','r','j')],[('j','v','r'),('v','j','r')],[('j','r','v'),('r','j','v')]])
rels = [rela,relb,relc]


-- definition de holds_a_rouge, holds_a_jaune, holds_a_vert etc

holds_a_rouge = Disj [Info('r','v','j'),Info('r','j','v')]
holds_a_jaune = Disj [Info('j','v','r'),Info('j','r','v')]
holds_a_verte = Disj [Info('v','r','j'),Info('v','j','r')]
holds_b_rouge = Disj [Info('v','r','j'),Info('j','r','v')]
holds_b_jaune = Disj [Info('v','j','r'),Info('r','j','v')]
holds_b_verte = Disj [Info('r','v','j'),Info('j','v','r')]
holds_c_rouge = Disj [Info('j','v','r'),Info('v','j','r')]
holds_c_jaune = Disj [Info('r','v','j'),Info('v','r','j')]
holds_c_verte = Disj [Info('j','r','v'),Info('r','j','v')]


model0 :: EpistM (Char,Char,Char)
model0 = Mo allHands [a,b,c] [] rels []


--Première Séquence

model1 :: EpistM (Char,Char,Char)
model1 = upd_pa model0 (Kn b (Ng holds_b_jaune))
--Mo [('r','v','j'),('j','r','v'),('j','v','r'),('v','r','j')] [a,b,c] [] [(a,[[('r','v','j')],[('j','r','v'),('j','v','r')],[('v','r','j')]]),(b,[[('r','v','j'),('j','v','r')],[('v','r','j'),('j','r','v')]]),(c,[[('r','v','j'),('v','r','j')],[('j','v','r')],[('j','r','v')]])] []

model2 :: EpistM (Char,Char,Char)
model2 = upd_pa model1 (Ng (Kn a holds_b_rouge))
--Mo [('r','v','j'),('j','r','v'),('j','v','r')] [a,b,c] [] [(a,[[('r','v','j')],[('j','r','v'),('j','v','r')]]),(b,[[('r','v','j'),('j','v','r')],[('j','r','v')]]),(c,[[('r','v','j')],[('j','v','r')],[('j','r','v')]])] []

model3 :: EpistM (Char,Char,Char)
model3 = upd_pa model2 (Kn a (Ng holds_a_jaune))
--Mo [('r','v','j')] [a,b,c] [] [(a,[[('r','v','j')]]),(b,[[('r','v','j')]]),(c,[[('r','v','j')]])] []


--On voit donc que on as un seul monde possible où A a la carte rouge, B a la carte verte et C a la carte Jaune et donc que a b et c on des relations réfléxives sur ce monde donc qe tout le monde connait les cartes de tout le monde.

--Deuxième sequence

model1bis :: EpistM (Char,Char,Char)
model1bis = upd_pa model0 (Kn c (Ng holds_c_jaune))
--Mo [('r','j','v'),('j','r','v'),('j','v','r'),('v','j','r')] [a,b,c] [] [(a,[[('r','j','v')],[('j','r','v'),('j','v','r')],[('v','j','r')]]),(b,[[('j','v','r')],[('r','j','v'),('v','j','r')],[('j','r','v')]]),(c,[[('j','v','r'),('v','j','r')],[('j','r','v'),('r','j','v')]])] []

model2bis :: EpistM (Char,Char,Char)
model2bis = upd_pa model1bis (Ng (Kn a (Kn b holds_b_jaune)))
--Mo [('j','r','v'),('j','v','r')] [a,b,c] [] [(a,[[('j','r','v'),('j','v','r')]]),(b,[[('j','v','r')],[('j','r','v')]]),(c,[[('j','v','r')],[('j','r','v')]])] []

model3bis :: EpistM (Char,Char,Char)
model3bis = upd_pa model2bis (Kn c (Ng holds_b_verte))
--Mo [('j','r','v')] [a,b,c] [] [(a,[[('j','r','v')]]),(b,[[('j','r','v')]]),(c,[[('j','r','v')]])] []


--On voit donc dans cette séquence qu'on obtient qu'un seul monde où A a la carte jaune, B la carte R et C la carte V et que a b et c on des relations réfléxives sur ce monde donc qe tout le monde connait les cartes de tout le monde.

