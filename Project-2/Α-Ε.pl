% [Για φοιτητές με επώνυμο από Α έως Ε]
precede_list([], _).
precede_list([X|Y1], [X|Y2]):- precede_list(Y1, Y2).