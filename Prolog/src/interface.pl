opcoesMenu() :-
    writeln('\n=-=-=-=-=-=-=- GERENCIADOR KANBAN -=-=-=-=-=-=-=\n'),
    write('1 - Fazer login\n'),
    write('2 - Cadastrar\n'),
    write('3 - Encerrar programa\n'),
    write('\nEscolha uma opcao: ').

opcoesMenuUsuario() :-
    writeln('\n=-=-=-=- BEM-VINDO AO GERENCIADOR KANBAN -=-=-=-=\n'),
    write('1 - Visualizar Workspaces\n'),
    write('2 - Acessar uma Workspace\n'),
    write('3 - Criar uma Workspace\n'),
    write('4 - Sair\n'),
    write('\nEscolha uma opcao: ').

opcoesMenuWorkspace() :-
    writeln('\n=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n'),
    write('1 - Visualizar dados de uma tarefa\n'),
    write('2 - Criar tarefa\n'),
    write('3 - Atualizar status de uma tarefa\n'),
    write('4 - Excluir uma tarefa\n'),
    write('5 - Sair da Workspace\n'),
    write('\nEscolha uma opcao: ').

tituloWorkspace() :-
    writeln('\n=-=-=-=-=-=-=-=-=- WORKSPACE -=-=-=-=-=-=-=-=-=\n').

tituloParaFazer() :-
    writeln('\n|=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=|'),
    writeln('|                    PARA FAZER                 |'),
    writeln('|=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=|\n').

tituloEmAndamento() :-
    writeln('\n|=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=|'),
    writeln('|                 EM ANDAMENTO                  |'),
    writeln('|=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=|\n').

tituloPronto() :-
    writeln('\n|=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=|'),
    writeln('|                     PRONTA                    |'),
    writeln('|=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=|\n').

erroUsuarioNaoExiste() :-
    write('\nO usuario nao esta cadastrado para o CPF digitado.\n').

erroUsuarioJaExiste() :-
    write('\nO usuario ja esta cadastrado para o CPF digitado.\n').

erroUsuarioSenhaIncorreta() :-
    write('\nA senha digitada esta incorreta.\n').

erroSemWorkspace() :-
    write('O usuario nao possui Workspaces criadas.\n').

erroWorkspaceInexistente() :-
    write('\nNao ha Workspace com este nome para este usuario.\n').
    
erroWorkspaceJaExiste() :-
    write('\nJa existe um Workspace com este nome para este usuario.\n').

erroTarefaNaoExiste() :-
    write('\nA tarefa digitada nao existe para esta Workspace.\n').

erroTarefaJaExiste() :-
    write('\nA tarefa digitada ja exite para esta Workspace.\n').

erroStatusInvalido() :-
    write('\nO valor digitado eh invalido.\n').

encerramentoPrograma() :-
    write('\n=-=-=-=-=-=-=-=- ENCERRANDO... -=-=-=-=-=-=-=-=\n'), 
    halt.