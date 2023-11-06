print_spaces(0).
print_spaces(N) :- 
    N > 0, 
    N1 is N - 1, 
    put_char(' '), 
    print_spaces(N1).


print_board(Board):-
    print_board(Board,0). %To Start up the I counter

print_board([],_).

print_board([Row],I):-
    print_row_last(Row,I).

print_board([Row|Rest],I) :-
    length(Rest,SizeRest),
    NewI is I + 1,
    print_row(Row,I),
    print_board(Rest,NewI).


print_row(Row,I):-
    count_occurrences(3, Row, Count3),
    AmmountSpaces1 is 2 * Count3,
    AmmountSpaces2 is AmmountSpaces1 - 1,
    format('i = ~w',I),
    put_code(9),%tab!
    print_spaces(AmmountSpaces1),
    print_middle_row(Row),
    length(Row,SizeRow),
    AmmountConnectors is SizeRow - Count3,
    nth0(0,Row,First), %gets the first character, if its not a 3 then we invert the connectors!
    nl,
    put_code(9),
    print_connectors(First,AmmountConnectors,AmmountSpaces2),
    nl.

print_row_last(Row,I):-
    count_occurrences(3, Row, Count3),
    length(Row,SizeRow),
    AmmountJs is SizeRow - Count3,
    AmmountSpaces1 is 2 * Count3,
    format('i = ~w',I),
    put_code(9),%tab!
    print_spaces(AmmountSpaces1),
    print_middle_row(Row),
    nl,
    put_code(9),%tab!
    AmmountSpaces2 is AmmountSpaces1 -1,
    print_spaces(AmmountSpaces2),
    print_js(AmmountJs,0),
    nl.

print_middle_row([]).

%For the cases where it's the last element (or followed by a 3) and we don't want the --- after it
print_middle_row([0]):-
    put_char(o).
print_middle_row([1]):-
    put_char('W').
print_middle_row([2]):-
    put_char('B').
print_middle_row([0,3 | _]):-
    put_char(o).
print_middle_row([1,3 | _]):-
    put_char('W').
print_middle_row([2,3 | _]):-
    put_char('B').

%When its in the middle
print_middle_row([0|Rest]):-
    put_char('o'),
    write('---'),
    print_middle_row(Rest).
print_middle_row([1|Rest]):-
    put_char('W'),
    write('---'),
    print_middle_row(Rest).
print_middle_row([2|Rest]):-
    put_char('B'),
    write('---'),
    print_middle_row(Rest).

print_middle_row([3|Rest]):-
    print_middle_row(Rest).



print_connectors(3, AmmountConnectors,AmmountSpaces) :-
    print_spaces(AmmountSpaces),
    AmmountConnectors > 0,
    write('/ \\ '),
    New is AmmountConnectors - 1,
    print_connectors_inner(New, 3,0).

print_connectors(_, AmmountConnectors,AmmountSpaces) :-
    AmSpaces is AmmountSpaces + 1,
    print_spaces(AmSpaces),
    AmmountConnectors > 0,
    write(' \\ / '),
    New is AmmountConnectors - 2,
    CounterJ is AmmountConnectors - 1,
    print_connectors_inner(New, 0,CounterJ).

print_connectors_inner(0,0,J):-
    format('j=~d',J).

print_connectors_inner(0, _,_).
print_connectors_inner(AmmountConnectors, First,J) :-
    AmmountConnectors > 0,
    (First = 3 -> write('/ \\ '); write('\\ / ')),
    New is AmmountConnectors - 1,
    print_connectors_inner(New, First,J).

print_js(0,_).

print_js(AmmountJs,Counter):-
    AmmountJs > 0,
    format('j=~d|',Counter),
    NewJs is AmmountJs -1,
    NewCounter is Counter + 1,
    print_js(NewJs,NewCounter).
    

print_available_moves(AvailableMoves):-
    nl,
    write('Here are the following available moves:'),
    nl,
    print_available_moves_inner(AvailableMoves).

print_available_moves_inner([]).
print_available_moves_inner([[StartPos, TargetPos] | Rest]):-
    put_code(9),
    format("-Move from ~w to ~w", [StartPos, TargetPos]),
    nl,
    print_available_moves_inner(Rest).


