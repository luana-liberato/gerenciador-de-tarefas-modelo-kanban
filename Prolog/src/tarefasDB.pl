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
    lerArquivo('tarefas.csv', File),
    getTarefaById(CPF, Workspace, NomeTarefa, File, Tarefa),
    (Tarefa == [] -> erroTarefaNaoExiste;
    showTarefa(Tarefa)).

getTarefaById(_, _, _, [], []).
getTarefaById(CPF, Workspace, NomeTarefa, [row(CPF, Workspace, NomeTarefa, Detalhes, Status, Prioridade)|_], row(CPF, Workspace, NomeTarefa, Detalhes, Status, Prioridade)).
getTarefaById(CPF, Workspace, NomeTarefa, [_|B], T) :- getTarefaById(CPF, Workspace, NomeTarefa, B, T).

showTarefa(Tarefa) :-
    rowTarefa(Tarefa, _, _, NomeTarefa, Detalhes, Status, Prioridade),
    write('\nNome tarefa: '),
    write(NomeTarefa),
    write('\nDetalhes da tarefa: '),
    write(Detalhes),
    write('\nStatus da tarefa: '),
    write(Status),
    write('\nPrioridade da tarefa: '),
    write(Prioridade),
    write('\n').

procurarTarefa(CPF, Workspace, Nome, Verificador) :-
    lerArquivo('tarefas.csv', File),
    procurar(CPF, Workspace, Nome, File, Verificador),
    write(Verificador).

procurar(_, _, _, [], false).
procurar(CPF, NomeWorkspace, NomeTarefa, [row(CPF, NomeWorkspace, NomeTarefa, _, _)|_], true).
procurar(CPF, NomeWorkspace, NomeTarefa, [_|B], V) :- procurar(CPF, NomeWorkspace, NomeTarefa, B, V).

removerTarefa(CPF, Workspace, NomeTarefa) :-
    lerArquivo('tarefas.csv', File),
    getTarefaById(CPF, Workspace, NomeTarefa, File, Tarefa),
    novaListaTarefas(Tarefa, File, Tarefas),
    limparTarefas,
    reescritaTarefas(Tarefas).

novaListaTarefas(Tarefa, [Tarefa|T], T).
novaListaTarefas(Tarefa, [H|T], [H|T1]) :- novaListaTarefas(Tarefa, T, T1).
    
limparTarefas() :-
    open('./dados/tarefas.csv', write, File),
    write(File, ''),
    close(File).

reescritaTarefas([]).
reescritaTarefas([row(CPF, NomeWorkspace, NomeTarefa, Detalhes, Status, Prioridade)|T]) :-
    criarTarefa(CPF, NomeWorkspace, NomeTarefa, Detalhes, Status, Prioridade),
    reescritaTarefas(T).

rowTarefa(row(CPF, NomeWorkspace, NomeTarefa, Detalhes, Status, Prioridade), CPF, NomeWorkspace, NomeTarefa, Detalhes, Status, Prioridade).
%alterarStatus(12345678910, 'Projeto PLP', 'Criacao de Tarefa', 'Pronta').
alterarStatus(CPF, Workspace, Nome, Status) :-
    lerArquivo('tarefas.csv', File),
    write(Status),
    getTarefaById(CPF, Workspace, Nome, File, Tarefa),
    novaListaTarefas(Tarefa, File, Tarefas),
    limparTarefas,
    reescritaTarefas(Tarefas),
    rowTarefa(Tarefa, _, _, _, Detalhes, _, Prioridade),
    criarTarefa(CPF, Workspace, Nome, Detalhes, Status, Prioridade).
