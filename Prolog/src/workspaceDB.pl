:- use_module(library(csv)).
:- include('workspace.pl').

criarWorkspace(NomeWorkspace, CPF) :-
    open('./dados/workspace.csv', append, File),
    writeln(File, (CPF, NomeWorkspace)),                 
    close(File).

listarWorkspaces(CPF) :-
    csv_read_file('./dados/workspace.csv', File),
    exibirWorkspaces(CPF, File).

existeWorkspace(_, _, [], false).
existeWorkspace(CPF, NomeWorkspace, [row(CPF, NomeWorkspace)|_], true).
existeWorkspace(CPF, NomeWorkspace, [_|B], V):- existeWorkspace(CPF, NomeWorkspace, B, V).

existeWorkspaceTest(CPF, NomeWorkspace) :-
    csv_read_file('./dados/workspace.csv', Arq),
    existeWorkspace(CPF, NomeWorkspace, Arq, V),
    write(V),
    halt.
