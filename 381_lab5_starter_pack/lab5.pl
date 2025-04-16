/***************************************/
%     CS 381 - Programming Lab #5       %
%                                       %
%  Ishanshi Bhardwaj                    %
%  bhardwai@oregonstate.edu             %
%                                       %
/***************************************/

% Load family tree
:- consult('royal.pl').

% Enables piping in tests
portray(Term) :- atom(Term), format("~s", Term).

/***************************************/
% Family Relationships                 %
/***************************************/

% Parent-child relationships
mother(M, C) :- parent(M, C), female(M).   % M is the mother of C
father(F, C) :- parent(F, C), male(F).     % F is the father of C
child(C, P) :- parent(P, C).               % C is a child of P
son(S, P) :- child(S, P), male(S).         % S is a son of P
daughter(D, P) :- child(D, P), female(D).  % D is a daughter of P

% Sibling relationships
sibling(A, B) :- parent(P, A), parent(P, B), A \= B.  % A and B share at least one parent
brother(B, A) :- sibling(B, A), male(B).              % B is a brother of A
sister(S, A) :- sibling(S, A), female(S).             % S is a sister of A

% Spouse relationship
spouse(A, B) :- married(A, B); married(B, A).  % A is the spouse of B

/***************************************/
% Extended Family Relationships        %
/***************************************/

% Grandparent-grandchild relationships
grandparent(G, C) :- parent(G, P), parent(P, C).        % G is a grandparent of C
grandfather(GF, C) :- grandparent(GF, C), male(GF).     % GF is a grandfather of C
grandmother(GM, C) :- grandparent(GM, C), female(GM).   % GM is a grandmother of C
grandchild(GC, G) :- grandparent(G, GC).                % GC is a grandchild of G

% Uncle and aunt relationships
uncle(U, N) :- parent(P, N), brother(U, P).             % U is an uncle of N (by blood)
uncle(U, N) :- parent(P, N), sibling(P, S), spouse(U, S), male(U).  % U is an uncle of N (by marriage)
aunt(A, N) :- parent(P, N), sister(A, P).               % A is an aunt of N (by blood)
aunt(A, N) :- parent(P, N), sibling(P, S), spouse(A, S), female(A). % A is an aunt of N (by marriage)

/***************************************/
% Generational Relationships           %
/***************************************/

% Ancestors and descendants
ancestor(A, D) :- parent(A, D).                         % Base case: A is a parent of D
ancestor(A, D) :- parent(P, D), ancestor(A, P).         % Recursive case
descendant(D, A) :- child(D, A).                        % Base case: D is a child of A
descendant(D, A) :- child(C, A), descendant(D, C).      % Recursive case

/***************************************/
% Temporal Relationships               %
/***************************************/

% Age comparison
older(X, Y) :- born(X, BX), born(Y, BY), BX < BY.       % X is older than Y
younger(X, Y) :- born(X, BX), born(Y, BY), BX > BY.     % X is younger than Y

% Regency during birth
regentWhenBorn(R, P) :- 
    born(P, BP), 
    reigned(R, Start, End), 
    BP > Start, 
    BP =< End.                                          % R was regent when P was born

/***************************************/
% Cousin Relationships                 %
/***************************************/

% First cousins
cousin(C1, C2) :- 
    parent(P1, C1), 
    parent(P2, C2), 
    sibling(P1, P2), 
    C1 \= C2.                                           % C1 and C2 share grandparents but not parents
