:- (initialization main).
:- include('interface.pl').
:- include('usuarioDB.pl').
:- include('workspaceDB.pl').
:- include('tarefasDB.pl').
:- include('util.pl').

main :-
    menuPrincipal.

menuPrincipal() :-
    opcoesMenu,
    read(Opcao),
    escolheMenu(Opcao).

escolheMenu(1) :- loginUsuario.
escolheMenu(2) :- cadastroUsuario.
escolheMenu(3) :- encerramentoPrograma.
escolheMenu(_) :- menuPrincipal.

loginUsuario() :-
    writeln("\n-------------------- LOGIN --------------------\n"),
    write("Digite o seu CPF sem (.) ou (-): "),
    read(CPF),
    write("Digite sua senha: "),
    read(Senha),
    procurarUsuario(CPF, VerificadorCPF),
    (VerificadorCPF == false -> erroUsuarioNaoExiste, sleep(3);
        autenticarUsuario(CPF, Senha, VerificadorSenha),
        (VerificadorSenha == false -> erroUsuarioSenhaIncorreta;
        sleep(1),
        menuUsuario(CPF))
    ),
    sleep(3),
    menuPrincipal.

cadastroUsuario() :-
    writeln("\n------------------- CADASTRO -------------------\n"),
    write("Digite seu nome: "),
    read(Nome),
    write("Digite o seu CPF sem (.) ou (-): "),
    read(CPF),
    procurarUsuario(CPF, VerificadorCPF),
    (VerificadorCPF == false -> write("Digite uma senha: "),
        read(Senha),
        criarUsuario(Nome, CPF, Senha);
        erroUsuarioJaExiste,
        sleep(3)
    ),
    sleep(1),
    menuPrincipal.

menuUsuario(CPF) :-
    opcoesMenuUsuario,
    read(Opcao),
    escolheMenuUsuario(Opcao, CPF).

escolheMenuUsuario(1, CPF) :- visualizarWorkspaces(CPF).
escolheMenuUsuario(2, CPF) :- acessarWorkspace(CPF).
escolheMenuUsuario(3, CPF) :- cadastroWorkspace(CPF).
escolheMenuUsuario(4, _) :- menuPrincipal.
escolheMenuUsuario(_, CPF) :- menuUsuario(CPF).

visualizarWorkspaces(CPF) :-
    writeln("\n------------- LISTA DE WORKSPACES -------------\n"),
    listarWorkspaces(CPF),
    sleep(3),
    menuUsuario(CPF).

acessarWorkspace(CPF) :-
    writeln("\n-------------- ACESSAR WORKSPACE --------------\n"),
    write('Digite o nome da Workspace que deseja acessar: '),
    read(NomeWorkspace),
    procurarWorkspace(CPF, NomeWorkspace, VerificadorWorkspace),
    (VerificadorWorkspace == false -> erroWorkspaceInexistente, sleep(3), menuUsuario(CPF);
    sleep(1),
    workspace(CPF, NomeWorkspace)).

cadastroWorkspace(CPF) :-
    writeln("\n------------- CRIACAO DE WORKSPACE -------------\n"),
    write("Digite o nome da sua nova Workspace: "),
    read(NomeWorkspace),
    procurarWorkspace(CPF, NomeWorkspace, VerificadorWorkspace),
    (VerificadorWorkspace == true -> erroWorkspaceJaExiste, sleep(3);
    sleep(1),
    criarWorkspace(NomeWorkspace, CPF)),
    menuUsuario(CPF).

workspace(CPF, NomeWorkspace) :-
    tituloWorkspace,
    format('>> Workspace: ~w~n', NomeWorkspace),
    sleep(1),
    tituloParaFazer,
    showTarefasByStatus(CPF, Workspace, 'Para fazer'),
    sleep(3),
    tituloEmAndamento,
    showTarefasByStatus(CPF, Workspace, 'Em andamento'),
    sleep(3),
    tituloPronto,
    showTarefasByStatus(CPF, Workspace, 'Pronta'),
    sleep(3),
    opcoesMenuWorkspace,
    read(Opcao),
    escolheMenuWorkspace(Opcao, CPF, NomeWorkspace).

escolheMenuWorkspace(1, CPF, NomeWorkspace) :- lerTarefa(CPF, NomeWorkspace).
escolheMenuWorkspace(2, CPF, NomeWorkspace) :- cadastroTarefa(CPF, NomeWorkspace).
escolheMenuWorkspace(3, CPF, NomeWorkspace) :- atualizarStatus(CPF, NomeWorkspace).
escolheMenuWorkspace(4, CPF, NomeWorkspace) :- excluirTarefa(CPF, NomeWorkspace).
escolheMenuWorkspace(5, CPF, _) :- menuUsuario(CPF).
escolheMenuWorkspace(_, CPF, NomeWorkspace) :- workspace(CPF, NomeWorkspace).

lerTarefa(CPF, NomeWorkspace) :-
    writeln("\n---------------- LEITURA TAREFA ----------------\n"),
    write('Digite o nome da tarefa que deseja visualizar: '),
    read(NomeTarefa),
    visualizarTarefa(CPF, NomeWorkspace, NomeTarefa),
    sleep(7),
    workspace(CPF, NomeWorkspace).

cadastroTarefa(CPF, NomeWorkspace) :-
    writeln("\n--------------- CRIACAO DE TAREFA ---------------\n"),
    write('Digite o nome da nova tarefa: '),
    read(NomeTarefa),
    procurarTarefa(CPF, NomeWorkspace, NomeTarefa, VerificadorTarefa),
    % Teste nao esta funcionando
    (VerificadorTarefa == true -> erroTarefaJaExiste, sleep(3);
    detalhesTarefa(Detalhes, NomeTarefa),
    statusTarefa(Status, NomeTarefa),
    prioridadeTarefa(Prioridade, NomeTarefa),
    criarTarefa(CPF, NomeWorkspace, NomeTarefa, Detalhes, Status, Prioridade)),
    workspace(CPF, NomeWorkspace).

detalhesTarefa(Detalhes, Nome) :-
    write('\nDeseja informar detalhes para a tarefa '),
    write(Nome),
    writeln('?'),
    writeln('\n1 - Para sim'),
    writeln('2 - Para nao'),
    read(Opcao),
    opcoesDetalhesTarefa(Opcao, Detalhes, Nome).

opcoesDetalhesTarefa(1, Detalhes, _) :- read(Detalhes).
opcoesDetalhesTarefa(2, Detalhes, _) :- Detalhes = "Sem detalhes".
opcoesDetalhesTarefa(_, Detalhes, Nome) :- detalhesTarefa(Detalhes, Nome).

statusTarefa(Status, Nome) :-
    write('\nInforme o status inicial da tarefa '),
    writeln(Nome),
    writeln('\n1 - Para fazer'),
    writeln('2 - Em andamento'),
    writeln('3 - Pronta'),
    read(Opcao),
    opcoesStatusTarefa(Opcao, Status, Nome).

opcoesStatusTarefa(1, Status, _) :- Status = 'Para fazer'.
opcoesStatusTarefa(2, Status, _) :- Status = 'Em andamento'.
opcoesStatusTarefa(3, Status, _) :- Status = 'Pronta'.
opcoesStatusTarefa(_, Status, Nome) :- statusTarefa(Status, Nome).

prioridadeTarefa(Prioridade, Nome) :-
    write('\nInforme uma prioriadade inicial pra tarefa '),
    writeln(Nome),
    writeln('\n1 - Alta'),
    writeln('2 - Media'),
    writeln('3 - Baixa'),
    read(Opcao),
    opcoesPrioridadeTarefa(Opcao, Prioridade, Nome).

opcoesPrioridadeTarefa(1, Prioridade, _) :- Prioridade = 'Alta'.
opcoesPrioridadeTarefa(2, Prioridade, _) :- Prioridade = 'Media'.
opcoesPrioridadeTarefa(3, Prioridade, _) :- Prioridade = 'Baixa'.
opcoesPrioridadeTarefa(_, Prioridade, Nome) :- prioridadeTarefa(Prioridade, Nome).

excluirTarefa(CPF, NomeWorkspace) :-
    writeln("\n--------------- EXCLUSAO DE TAREFA ---------------\n"),
    write('Digite o nome da tarefa: '),
    read(NomeTarefa),
    removerTarefa(CPF, NomeWorkspace, NomeTarefa),
    workspace(CPF, NomeWorkspace).

atualizarStatus(CPF, NomeWorkspace) :-
    writeln("\n---------------- STATUS DE TAREFA ----------------\n"),
    write('Digite o nome da tarefa que deseja alterar: '),
    read(NomeTarefa),
    write('\nInforme o status da da tarefa: '),
    writeln('\n1 - Para fazer'),
    writeln('2 - Em andamento'),
    writeln('3 - Pronta'),
    read(Opcao),
    (Opcao == 1 -> alterarStatus(CPF, NomeWorkspace, NomeTarefa, 'Para fazer');
    Opcao == 2 -> alterarStatus(CPF, NomeWorkspace, NomeTarefa, 'Em andamento');
    Opcao == 3 -> alterarStatus(CPF, NomeWorkspace, NomeTarefa, 'Pronta');
    erroStatusInvalido, sleep(3), atualizarStatus(CPF, NomeWorkspace)),
    sleep(1),
    workspace(CPF, NomeWorkspace).

