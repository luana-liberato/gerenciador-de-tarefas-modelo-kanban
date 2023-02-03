:- use_module(library(csv)).
:- include('interface.pl').
:- include('util.pl').

criarTarefa(CPF, NomeWorkspace, NomeTarefa, Detalhes, Status, Prioridade) :-
    open('./dados/tarefas.csv', append, File),
    writeln(File, (CPF, NomeWorkspace, NomeTarefa, Detalhes, Status, Prioridade)),                 
    close(File).

getTarefasByStatusPrioridade(_, _, _, _, [], []).
getTarefasByStatusPrioridade(CPF, Workspace, Status, Prioridade, [row(CPF, Workspace, NomeTarefa, _, Status, Prioridade)|[]], [NomeTarefa]).
getTarefasByStatusPrioridade(CPF, Workspace, Status, Prioridade, [row(CPF, Workspace, NomeTarefa, _, Status, Prioridade)|T], R) :-
    getTarefasByStatusPrioridade(CPF, Workspace, Status, Prioridade, T, S), append([NomeTarefa], S, R).
getTarefasByStatusPrioridade(CPF, Workspace, Status, Prioridade, [_|T], R) :-
    getTarefasByStatusPrioridade(CPF, Workspace, Status, Prioridade, T, R).

getTarefasByStatus(CPF, Workspace, Status, L) :-
    csv_read_file('./dados/tarefas.csv', File),
    getTarefasByStatusPrioridade(CPF, Workspace, Status, 'Alta', File, R0),
    getTarefasByStatusPrioridade(CPF, Workspace, Status, 'Media', File, R1),
    getTarefasByStatusPrioridade(CPF, Workspace, Status, 'Baixa', File, R2),
    (R0 == [], R1 == [], R2 == [] -> L = ['Nao ha tarefas nesta workspace com este status.'];
    append(R0, R1, S0),
    append(S0, R2, L)
    ).

showTarefasByStatus(CPF, Workspace, Status) :-
    getTarefasByStatus(CPF, Workspace, Status, L),
    showList(L).
    

