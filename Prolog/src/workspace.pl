:- include('interface.pl').

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
exibirWorkspaces(CPF, [_|[]]).
exibirWorkspaces(CPF, [_|B]) :- exibirWorkspaces(CPF, B).