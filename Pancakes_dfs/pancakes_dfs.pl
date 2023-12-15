pancakes_dfs(InitialState) :-
    findall(States, pancakes_dfs(InitialState, [], [InitialState], States), X), length(X, N), write("Length = "), write(N).

% Check if current state is the final state.
pancakes_dfs(InitialState, Operators, States, States) :- final_state(InitialState, Operators, States), !.

% Recursive call to pancakes_dfs/3 to solve the problem.
pancakes_dfs(InitialState, Operators, States, FinalStates) :-
    length(InitialState, N),
    between(1, N, Operator),
    not(operatorIsAtBeginning(Operator, InitialState)),
    move(InitialState, Operator, NextState),
    not(member(NextState, States)),
    append(Operators, [Operator], NewOperators),
    %write("Operators = "), write(NewOperators), nl,
    append(States, [NextState], NewStates),
    pancakes_dfs(NextState, NewOperators, NewStates, FinalStates).

move(InitialState, Operator, NextState) :-
    getReversedList(InitialState, Operator, List, AfterOprtList),
    append(List, AfterOprtList, NextState).

% Get the reversed list(or sublist) from the beginning of the list
% until the index of the operator. If the returned list is a sublist,
% the AfterOprtList will contain the rest of the list.
getReversedList([Operator|Tail], Operator, [Operator], Tail).
getReversedList([X|Tail], Operator, SubList, AfterOprtList) :-
    getReversedList(Tail, Operator, List, AfterOprtList),
    append(List, [X], SubList).

% Final state is reached when the list has only one element, which means
% that the list is sorted.
%final_state([A], Operators, States) :- write("States = "), write(States), nl, nl.
final_state([A], Operators, States).

% Recursive call to final_state/1 to check if the list is sorted.
final_state([A,B|Tail], Operators, States) :-
    A =< B,
    final_state([B|Tail], Operators, States).

% Check if the operator is at the beginning of the list.
operatorIsAtBeginning(Operator, [Operator|Tail]).

% NOTE:
% Problem occurs when the list is too long. The program will run out of memory.