:- use_module(library(csv)).
:- include('interface.pl').
:- include('util.pl').

criarWorkspace(NomeWorkspace, CPF) :-
    open('./dados/workspace.csv', append, File),
    writeln(File, (CPF, NomeWorkspace)),                 
    close(File).

listarWorkspaces(CPF) :-
    lerArquivo('workspace.csv', File),
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

procurarWorkspace(CPF, Workspace, Verificador) :-
    lerArquivo('workspace.csv', File),
    procurar(CPF, Workspace, File, Verificador).

procurar(_, _, [], false).
procurar(CPF, NomeWorkspace, [row(CPF, NomeWorkspace)|_], true).
procurar(CPF, NomeWorkspace, [_|B], V) :- procurar(CPF, NomeWorkspace, B, V).