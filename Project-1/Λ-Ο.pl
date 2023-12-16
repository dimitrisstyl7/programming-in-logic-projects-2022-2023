family(person(tom,fox,date(7,may,1950),works(bbc,15200)),
       person(ann,fox,date(9,may,1951),unemployed),
       [person(pat,fox,date(5,may,1973),unemployed),
       person(stephanie,ioannou,date(5,may,1973),unemployed)]).

family(person(giannos,ioannou,date(29,august,1978),works(engineer,24000)),
       person(elena,panteli,date(3,november,1979),works(economics,21600)),
       [person(christos,ioannou,date(22,february,2013),unemployed),
       person(stephanie,ioannou,date(22,february,2013),unemployed),
       person(marina,ioannou,date(27,december,2004),unemployed)]).

family(person(marios,papakosta,date(11,january,1951),works(professor,7000)),
       person(maria,christou,date(19,march,1949),works(programmer,7500)),
       [person(tasia,papakosta,date(17,december,1980),works(nurse,12000)),
       person(pantelis,papakosta,date(4,february,1985),unemployed)]).
	
family(person(ioakeim,stavrou,date(5,october,1980),works(teacher,12000)),
       person(eva,louca,date(24,july,1977),works(doctor,26400)),
       [person(christina,stavrou,date(21,march,2006),unemployed)]).
	
family(person(manwlhs,andreou,date(9,november,1945),works(accountant,7400)),
       person(ellada,pavlou,date(20,july,1946),works(chef,5550)),
	   []).

% [Για φοιτητές με επώνυμο από Λ έως Ο]
wife(Wife) :- family(_,Wife,_), Wife = person(_,_,_,works(_,_)).
getParent(Parent) :- family(Parent,_,_) ; family(_,Parent,_).
exists(Parent) :- getParent(Parent), Parent = person(_,_,date(_,_,Year),unemployed), Year < 1963.