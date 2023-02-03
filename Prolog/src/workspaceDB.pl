:- include('workspace.pl').

criarWorkspace(NomeWorkspace, CPF) :-
    open('./dados/workspace.csv', append, File),
    writeln(File, (CPF, NomeWorkspace)),                 
    close(File).

listarWorkspaces(CPF) :-
    csv_read_file('./dados/workspace.csv', File),
    exibirWorkspaces(CPF, File).