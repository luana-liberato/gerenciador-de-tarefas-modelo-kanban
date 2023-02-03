lerArquivo(Arquivo, File) :-
    atom_concat('./dados/', Arquivo, Caminho),
    csv_read_file(Caminho, File).

read_string(String) :- current_input(Stream),
                       read_line_to_codes(Stream, Input),
                       string_codes(String, Input).

showList([]) :- !.
showList([H|T]) :-
    write(H),
    write('\n'),
    showList(T).