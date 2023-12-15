% [Για φοιτητές με επώνυμο από Λ έως Ο]
included_list([],[]).
included_list([X|NewListA], [X|NewListB]) :- included_list(NewListA, NewListB).
included_list(ListA, [_|NewListB]) :- included_list(ListA, NewListB).