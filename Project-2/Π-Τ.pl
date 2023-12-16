% [Για φοιτητές με επώνυμο από Π έως Τ]
common_list([X|_], [X|_]) :- !.
common_list(ListA, [_|ListB]) :- common_list(ListA, ListB), !.
common_list([_|ListA], ListB) :- common_list(ListA, ListB), !.