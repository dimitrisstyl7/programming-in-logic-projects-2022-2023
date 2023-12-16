% [Για φοιτητές με επώνυμο από Υ έως Ω]
pair_list([], []).
pair_list([X,Y|ListA], [[X,Y]|ListB]) :- pair_list(ListA, ListB). 