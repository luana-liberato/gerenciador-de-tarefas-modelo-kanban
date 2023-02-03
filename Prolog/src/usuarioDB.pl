:- use_module(library(csv)).
:- include('interface.pl').

criarUsuario(Nome, CPF, Senha) :-
    open('./dados/usuario.csv', append, File),
    writeln(File, (CPF, Nome, Senha)),                 
    close(File).

autenticarUsuario(CPF, Senha, Verificador) :-
    csv_read_file('./dados/usuario.csv', File),
    procurarUsuario(CPF, File, V),
    (V == true -> autenticar(CPF, Senha, File, Verificador);
    erroUsuarioNaoExiste).
    
autenticar(_, _, [], false).
autenticar(CPF, Senha, [row(CPF, _, Senha)|_], true).
autenticar(CPF, Senha, [_|B], V):- autenticar(CPF, Senha, B, V).

procurarUsuario(_, [], false).
procurarUsuario(CPF, [row(CPF, _, _)|_], true).
procurarUsuario(CPF, [_|B], V):- procurarUsuario(CPF, B, V).