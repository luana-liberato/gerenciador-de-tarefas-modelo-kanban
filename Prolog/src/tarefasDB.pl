:- use_module(library(csv)).

criarTarefa(CPF, NomeWorkspace, NomeTarefa, Detalhes, Status, Prioridade) :-
    open('./dados/tarefas.csv', append, File),
    writeln(File, (CPF, NomeWorkspace, NomeTarefa, Detalhes, Status, Prioridade)),                 
    close(File).
