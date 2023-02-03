:- use_module(library(csv)).

criarTarefa(CPF, NomeWorkspace, NomeTarefa) :-
    open('./dados/tarefas.csv', append, File),
    writeln(File, (CPF, NomeWorkspace, NomeTarefa)),                 
    close(File).
