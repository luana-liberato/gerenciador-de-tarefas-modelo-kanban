:- (initialization main).
:- include('interface.pl').
:- include('usuarioDB.pl').
:- include('workspaceDB.pl').

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
    writeln("\n---------------- LOGIN ----------------\n"),
    write("Digite o seu CPF sem (.) ou (-): "),
    read(CPF),
    write("Digite sua senha: "),
    read(Senha),
    autenticarUsuario(CPF, Senha, Verificador),
    (Verificador == true -> menuUsuario(CPF);
    erroUsuarioSenhaIncorreta),
    menuPrincipal.

cadastroUsuario() :-
    writeln("\n--------------- CADASTRO ---------------\n"),
    write("Digite seu nome: "),
    read(Nome),
    write("Digite o seu CPF sem (.) ou (-): "),
    read(CPF),
    write("Digite uma senha: "),
    read(Senha),
    criarUsuario(Nome, CPF, Senha),
    main.

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
    writeln("\n--------- LISTA DE WORKSPACES ---------\n"),
    listarWorkspaces(CPF),
    menuUsuario(CPF).

acessarWorkspace(CPF) :-
    writeln("\n---------- ACESSAR WORKSPACE ----------\n"),
    write("Digite o nome da Workspace que deseja acessar: "),
    read(NomeWorkspace),
    workspace(CPF, NomeWorkspace)

cadastroWorkspace(CPF) :-
    writeln("\n-------- CRIACAO DE WORKSPACE --------\n"),
    write("Digite o nome da sua nova Workspace: "),
    read(NomeWorkspace),
    criarWorkspace(NomeWorkspace, CPF),
    menuUsuario(CPF).
    