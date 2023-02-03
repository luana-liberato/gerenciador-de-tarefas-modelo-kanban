:- use_module(library(csv)).
:- include('util.pl').
:- include('interface.pl').

criarUsuario(Nome, CPF, Senha) :-
    open('./dados/usuario.csv', append, File),
    writeln(File, (CPF, Nome, Senha)),                 
    close(File).

procurarUsuario(CPF, Verificador) :-
    lerArquivo('usuario.csv', File),
    procurar(CPF, File, Verificador).

procurar(_, [], false).
procurar(CPF, [row(CPF, _, _)|_], true).
procurar(CPF, [_|B], V):- procurar(CPF, B, V).

autenticarUsuario(CPF, Senha, Verificador) :-
    lerArquivo('usuario.csv', File),
    autenticar(CPF, Senha, File, Verificador).
    
autenticar(_, _, [], false).
autenticar(CPF, Senha, [row(CPF, _, Senha)|_], true).
autenticar(CPF, Senha, [_|B], V):- autenticar(CPF, Senha, B, V).