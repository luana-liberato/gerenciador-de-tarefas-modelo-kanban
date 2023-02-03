:- use_module(library(csv)).
:- include('interface.pl').

criarWorkspace(NomeWorkspace, CPF) :-
    open('./dados/workspace.csv', append, File),
    writeln(File, (CPF, NomeWorkspace)),                 
    close(File).

listarWorkspaces(CPF) :-
    csv_read_file('./dados/workspace.csv', File),
    exibirWorkspaces(CPF, File).

exibirWorkspaces(_, []) :- semWorkspace. 
exibirWorkspaces(CPF, [row(CPF, Nome)|[]]) :-
    write('Workspace: '),
    write(Nome),
    write('\n').
exibirWorkspaces(CPF, [row(CPF, Nome)|B]) :-
    write('Workspace: '),
    write(Nome),
    write('\n'),
    exibirWorkspaces(CPF, B).
exibirWorkspaces(_, [_|[]]).
exibirWorkspaces(CPF, [_|B]) :- exibirWorkspaces(CPF, B).

existeWorkspace(_, _, [], false).
existeWorkspace(CPF, NomeWorkspace, [row(CPF, NomeWorkspace)|_], true).
existeWorkspace(CPF, NomeWorkspace, [_|B], V):- existeWorkspace(CPF, NomeWorkspace, B, V).