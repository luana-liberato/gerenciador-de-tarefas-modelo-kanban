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

visualizarTarefa(CPF, Workspace, NomeTarefa) :-
    csv_read_file('./dados/tarefas.csv', File),
    write(NomeTarefa),
    verificarTarefa(CPF, Workspace, NomeTarefa, File).

verificarTarefa(_, _, _, []).
verificarTarefa(CPF, Workspace, Nome, [row(CPF, Workspace, Nome, Detalhes, Status, Prioridade),_]) :-
    write('Nome tarefa: '),
    write(NomeTarefa),
    write('Detalhes da tarefa: '),
    write(Detalhes),
    write('Status da tarefa: '),
    write(Status),
    write('Prioridade da tarefa :'),
    write(Prioridade).
verificarTarefa(CPF, Workspace, Nome, [_|B]).
    
showTarefa(Tarefa) :-
    rowTarefa(Tarefa, _, _, NomeTarefa, Detalhes, Status, Prioridade),
    write('Nome tarefa: '),
    write(NomeTarefa),
    write('Detalhes da tarefa: '),
    write(Detalhes),
    write('Status da tarefa: '),
    write(Status),
    write('Prioridade da tarefa :'),
    write(Prioridade).

getTarefaById(_, _, _, [], []).
getTarefaById(CPF, Workspace, NomeTarefa, [A|B], Tarefa) :-
    write(A),
    rowTarefa(A, TarefaCPF, TarefaWorkspace, TarefaNome, _, _, _),
    isTarefa(CPF, Workspace, NomeTarefa, R),
    (R == true -> showTarefa(A);
    getTarefasById(CPF, Workspace, NomeTarefa, B, Tarefa)). 

isTarefa(CPF, Workspace, NomeTarefa, true).
isTarefa(CPF, Workspace, NomeTarefa, false).

removerTarefa(CPF, Workspace, NomeTarefa) :-
    csv_read_file('./dados/tarefas.csv', File),
    getTarefaById(CPF, Workspace, NomeTarefa, File, Tarefa),
    limparTarefas,
    reescritaTarefas().
    
limparTarefas() :-
    open('./dados/Locacoes.csv', write, File),
    write(File, ''),
    close(File).

reescritaTarefas([]).
reescritaTarefas([H|T]) :-
    (rowTarefa(H, CPF, NomeWorkspace, NomeTarefa, Detalhes, Status, Prioridade),
    criarTarefa(CPF, NomeWorkspace, NomeTarefa, Detalhes, Status, Prioridade),
    escreveLocacoes(T)).

rowTarefa([CPF, NomeWorkspace, NomeTarefa, Detalhes, Status, Prioridade], CPF, NomeWorkspace, NomeTarefa, Detalhes, Status, Prioridade).