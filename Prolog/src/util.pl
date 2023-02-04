lerArquivo(Arquivo, File) :-
    atom_concat('./dados/', Arquivo, Caminho),
    csv_read_file(Caminho, File).

showList([]) :- !.
showList([H|T]) :-
    write(H),
    write('\n'),
    showList(T).