opcoesMenu() :-
    writeln('\n=-=-=-=-=- GERENCIADOR KANBAN -=-=-=-=-=\n'),
    write('1 - Fazer login\n'),
    write('2 - Cadastrar\n'),
    write('3 - Encerrar programa\n'),
    write('\nEscolha uma opcao: ').

opcoesMenuUsuario() :-
    writeln('\n=-=- BEM-VINDO AO GERENCIADOR KANBAN -=-=\n'),
    write('1 - Visualizar Workspaces\n'),
    write('2 - Acessar uma Workspace\n'),
    write('3 - Criar uma Workspace\n'),
    write('4 - Sair\n'),
    write('\nEscolha uma opcao: ').

tituloWorkspace() :-
    writeln('\n=-=-=-=-=-=-=- WORKSPACE -=-=-=-=-=-=-=\n').

tituloParaFazer() :-
    writeln('\n __________________________________________\n')
    writeln('\n|                PARA FAZER                |\n')
    writeln('\n ——————————————————————————————————————————\n').

tituloEmAndamento() :-
    writeln('\n __________________________________________\n')
    writeln('\n|               EM ANDAMENTO               |\n')
    writeln('\n ——————————————————————————————————————————\n').

tituloPronto() :-
    writeln('\n __________________________________________\n')
    writeln('\n|                  PRONTO                  |\n')
    writeln('\n ——————————————————————————————————————————\n').

erroUsuarioNaoExiste() :-
    write('\nO usuario nao esta cadastrado para o CPF digitado.\n').

erroUsuarioSenhaIncorreta() :-
    write('\nA senha digitada esta incorreta.\n').

semWorkspace() :-
    write('\nO usuario nao possui Workspaces criadas.\n').

encerramentoPrograma() :-
    write('\n=-=-=-=-=-=- ENCERRANDO.... -=-=-=-=-=-=\n'), 
    halt.