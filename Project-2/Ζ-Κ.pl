% [Για φοιτητές με επώνυμο από Ζ έως Κ]
proceed_list(List, List).
proceed_list([_|LongListRest], List) :- proceed_list(LongListRest, List).