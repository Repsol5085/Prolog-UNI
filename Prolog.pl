%lastInList(X,L)
lastInList(X,[X]).
lastInList(X,[_|T]):-lastInList(X,T).

lastButOne(X,[X,_]).
lastButOne(X,[_|T]):-lastButOne(X,T).

nthEl(1,[X|_],X).
nthEl(N,[_|T],X):-
    N>1,
    N1 is N-1,
    nthEl(N1,T,X).

lenght([],0).
lenght([_|T],X):-
    lenght(T,X1),
    X is X1+1.

%myreverse(L,R)
revHelper(RH,[],RH).
revHelper(RH,[H|T],R):-revHelper([H|RH],T,R).
reverse(R,L):-revHelper([],L,R).

palindrome(L):-reverse(R,L),palH(R,L).
palH([],[]).
palH([H|T1],[H|T2]):-palH(T1,T2).

append([],B,B).
append([H|TA],B,[H|TAB]):-
    append(TA,B,TAB).

remove(X,L,NL):-
    append(FRNT,[X|BACK],L),
    append(FRNT,BACK,NL).

add(X,L,NL):-
    remove(X,NL,L).
    
member(X,[X|_]).
member(X,[_|T]):-
    member(X,T).

member2(X,L):-
    append(_,[X|_],L).

prefix([],_).
prefix([H|P],[H|L]):-prefix(P,L).
prefix(P,L):-append(P,_,L).
suffix(S,L):-append(_,S,L).
infix(A,L):-append(B,_,L),append(_,A,B).

%subset(S,L).
subset([],_).
subset([H|T],L):-append(_,[H|B],L),subset(T,B).

issubset(A,B):-not((member(X,A),not(member(X,B)))).

% X - list of numbers ; Y - list of lists

%p1 - el. from X is also in Y
p1(X,Y):-member(T,X),member(P,Y),member(T,P).

%p2 - el. from X is all el. of Y
p2(X,Y):-member(T,X),not((member(P,Y),not(member(T,P)))).

%p3 - every el. of X is in an el. of Y
p3(X,Y):-not((member(T,X),not(member(P,Y),member(T,P)))).

%p4 - every el. of X is in every el. of Y
p4(X,Y):-not((member(T,X),member(P,Y),not(member(T,P)))).

qsort(S,[X|L]):-split(X,L,A,B),
    qsort(SA,A),qsort(SB,B),append(SA,[X|SB],S).

%noDuplicates(RES,L).
noDuplicates([],[]).
noDuplicates([X],[X]).
noDuplicates(R,[H,H|T]):-noDuplicates(R,[H|T]).
noDuplicates([H|TR],[H,H1|T]):-
    noDuplicates(TR,[H1|T]).

group([],[]).
group([[X]],[X]).
group([[H|L1]|RL],[H,H|T]):-group([L1|RL],[H|T]).
group([[H]|RL],[H,H1|T]):-group(RL,[H1|T]).

countEachEl([],[]).
countEachEl([[1,X]],[X]).
countEachEl([[COUNT,H]|G],[H,H|T]):-
    countEachEl([[COUNT1,H]|G],[H|T]),
    COUNT is COUNT1+1.
countEachEl([[1,H]|G],[H,H1|T]):-
    countEachEl(G,[H1|T]).

%duplicateEachEl(X,L)
duplicateEachEl([],[]).
duplicateEachEl([H,H|TX],[H|TL]):-
    duplicateEachEl(TX,TL).

%duplicateNtimes(RES,N,L).
duplicateNtimes([],_,[]).
duplicateNtimes(L,1,L).
duplicateNtimes(RES,N,L):-
    duplEl(RES,N,L,N).

duplEl([],_,[],_).
duplEl(RES,0,[_|L],N):-duplEl(RES,N,L,N).
duplEl([H|TR],K,[H|TL],N):-
    K>0,
    K1 is K-1,
    duplEl(TR,K1,[H|TL],N).

%dropEveryNth(RES,N,L).
dropEveryNth([],_,[]).
dropEveryNth(RES,N,L):-
    dropNth(RES,N,L,N).

dropNth([],_,[],_).
dropNth(RES,1,[_|L],N):-
  dropNth(RES,N,L,N).
dropNth([H|RES],K,[H|L],N):-
    K1 is K-1,
    dropNth(RES,K1,L,N).

slice([H|_],1,1,[H]).
slice([H|L],1,K,[H|RES]):-
    K>1,
    K1 is K-1,
    slice(L,1,K1,RES).
slice([_|L],I,K,RES):-
    I>1,
    I1 is I-1,
    K1 is K-1,
    slice(L,I1,K1,RES).

split([],_,[],[]).
split(O,0,[],O).
split([H|O],K,[H|L1],L2):-
    K1 is K-1,
    split(O,K1,L1,L2).

insertEl(L,X,N,RES):-
    N1 is N-1,
    split(L,N1,L1,L2),
    append(L1,[X|L2],RES).

mybetween(A,A,B):-
    A=<B.
mybetween(X,A,B):-
    A=<B,
    A1 is A+1,
    mybetween(X,A1,B).

prime(X):-
    X>1,
    X1 is X-1,
    not((mybetween(D,2,X1),X mod D =:=0)).

primeHelp([],X,Y):-Y>X.
primeHelp([N|L],N,T):-
    N<T,
    prime(N),
    N1 is N+1,
    primeHelp(L,N1,T).
primeHelp(L,N,T):-
    N<T,
    not(prime(N)),
    N1 is N+1,
    primeHelp(L,N1,T).
%--------------------------------------------------
%Natural number generator
n(0).
n(X):-
    n(X1),
    X is X1+1.
n(0,[],0).
n(N,[X|L],S):-
    N>0,
    mbetween(X,1,S),
    S1 is S-X,
    N1 is N-1,
    n(N1,L,S1).
n(N,L):-
    n(S),
    n(N,L,S).

%last==lastInList
last([X],X).
last([_|T],X):-
    last(T,X).

%gets the last elements of all the lists in a list.
lastEls([],[]).
lastEls([H|T],[LST|T1]):-
    last(H,LST),lastEls(T,T1).

%Pythagorean triple
pitag([N,M,K]):-N*N+M*M=:=K*K.

%sum is less than an el. in LST
smlSum(LST,N,M,K):-member(X,LST),N+M+K<X.

%gets every sublist's second element 
second([],[]).
second([[_]|T],SCN):-second(T,SCN).
second([[_,X|_]|T],[X|SCND]):-second(T,SCND).

%checks if N or M are members of SCND
notSec(SCND,N,M):-not(member(N,SCND)),not(member(M,SCND)).

%Main 
p(X,N,M,K):-
    n(3,[N,M,K]),
    pitag([N,M,K]),
    lastEls(X,LAST),
    smlSum(LAST,N,M,K),
    second(X,SCND),
    notSec(SCND,N,M).

%-------------------------------------------------
% Y-list of lists ; X - list of numbers
% task: 'p' checks if Y is a concat. of 2 el. from X
% 	if X has an even number of el.
%	sum of el. of X is last el. of Y


%uses lenght(L,Len).
%uses last(L,X).
%uses member(X,L).
%uses append(A,B,AB).


evenLen(X):-lenght(X,Len),Len mod 2=:=0.

sum1([],0).
sum1([H|T],S):-
    sum1(T,S1),
    S is S1+H.

%checks if last el of Y is the sum of X
lastIsSum(X,Y):-
    sum1(X,S),
    member(Y1,Y),
    last(Y1,LST),
    LST=:=S.

isConcat(X,Y):- member(A,Y),member(B,Y),append(A,B,X).

%Main
p(X,Y):-isConcat(X,Y),lastIsSum(X,Y),evenLen(X).

%-------------------------------------------------------------
%-------------------------------------------------------------

%Cartesian product dekart(D,L). L-list of lists
dekart([],[]).
dekart([H|D1],[A|L]):-member(H,A),dekart(D1,L).
%-------------------------------------------------------------
%-------------------------------------------------------------

%TREES

%gentree(T) -tree generator
gentree(T):-n(N),gentreeHelper(N,T).

gentreeHelper(0,[]).
gentreeHelper(N,[A|B]):-
    N>0,
    N1 is N-1,
    between(X,0,N1),
    Y is N1-X,
    gentreeHelper(X,A),
    gentreeHelper(Y,B).

empty([[],[]]).
edge([V,E],X,Y):-
    member(X,V),
    member(Y,V),
    member([X,Y],E);
    member([Y,X],E).

%path(G,V,X,Y,P):-%V-visited

%pathhelper(G,V,X,X,V).
pathhelper(G,V,X,Y,P):-
    edge(G,X,X1),
    not(member(X1,V)),
    pathhelper(G,[X|V],X1,Y,P).

path(G,X,Y,P):-
    pathhelper(G,[],X,Y,Q),
    reverse(Q,P).  



