{-# LANGUAGE OverloadedStrings #-}
module Main where
import Menu.Sistema
import Util.Utils ( telaInicial, telaCadastro, telaLogin, telaEncerramento, telaUsuario, tituloWorkspace, lerEntrada )
import Database.PostgreSQL.Simple ( Connection )
import LocalDB.ConnectionDB

import System.IO (utf8, hSetEncoding, stdout)
import Controller.UsuarioController
import Controller.WorkspaceController

main :: IO()
main = do
    hSetEncoding stdout utf8
    conn <- iniciandoDatabase

    menuPrincipal conn

-------- Menu Principal --------
menuPrincipal :: Connection -> IO()
menuPrincipal conn = do
    putStrLn(telaInicial)

    opc <- lerEntrada
    opcaoMenuPrincipal conn opc

opcaoMenuPrincipal :: Connection -> String -> IO()
opcaoMenuPrincipal conn opcao | (opcao == "1") = menuLogin conn
                              | (opcao == "2") = menuCadastro conn
                              | (opcao == "3") = putStrLn(telaEncerramento)
                              | otherwise = menuPrincipal conn

-------- Cadastro de Usuário --------
menuCadastro :: Connection -> IO()
menuCadastro conn = do
    putStrLn(telaCadastro)

    opc <- lerEntrada
    opcaoMenuCadastro conn opc

opcaoMenuCadastro :: Connection -> String -> IO()
opcaoMenuCadastro conn opcao | (opcao == "1") = cadastro conn
                             | (opcao == "2") = menuPrincipal conn
                             | otherwise = menuCadastro conn

cadastro :: Connection -> IO()
cadastro conn = do
    putStrLn(telaCadastro)

    putStrLn("\nInforme o seu nome completo:\n")
    nome <- lerEntrada

    putStrLn("\nCrie um login para identificação:\n")
    login <- lerEntrada

    putStrLn("\nCrie uma senha para acesso:\n")
    senha <- lerEntrada

    cadastroUsuario conn nome login senha

    menuPrincipal conn

-------- Login de Usuário --------
menuLogin :: Connection -> IO()
menuLogin conn = do
    putStrLn(telaLogin)

    opc <- lerEntrada
    opcaoMenuLogin conn opc

opcaoMenuLogin :: Connection -> String -> IO()
opcaoMenuLogin conn opcao | (opcao == "1") = login conn
                          | (opcao == "2") = menuPrincipal conn
                          | otherwise = menuLogin conn

login :: Connection -> IO()
login conn = do
    putStrLn(telaCadastro)

    putStrLn("\nInforme o seu login:\n")
    login <- lerEntrada

    putStrLn("\nInforme sua senha:\n")
    senha <- lerEntrada

    num <- ehUsuario conn login senha

    if (num == -404) then do
        putStrLn("\nUSUÁRIO NÃO ENCONTRADO!\n")
        menuLogin conn
    
    else if (num == -401) then do
        putStrLn("\nSENHA INCORRETA!\n")
        menuLogin conn

    else do
        menuUsuario conn num

-------- Interações do Usuário --------
menuUsuario :: Connection -> Int -> IO()
menuUsuario conn idUsuario = do
    putStrLn(telaUsuario)
    op <- lerEntrada

    opcaoMenuUsuario conn op idUsuario


opcaoMenuUsuario :: Connection -> String -> Int -> IO()
opcaoMenuUsuario conn opcao idUsuario | (opcao == "1") = criacaoWorkspace conn idUsuario
                                      | (opcao == "2") = mostrarWorkspaces conn idUsuario
                                      | (opcao == "3") = menuPrincipal conn
                                      | otherwise = menuLogin conn

criacaoWorkspace :: Connection -> Int -> IO()
criacaoWorkspace conn idUsuario = do
    putStrLn(tituloWorkspace)

    putStrLn("\nInforme um nome para Workspace:\n")
    nomeWorkspace <- lerEntrada

    cadastroWorkspace conn nomeWorkspace idUsuario
    menuUsuario conn idUsuario

mostrarWorkspaces :: Connection -> Int -> IO()
mostrarWorkspaces conn idUsuario = do
    l <- listarWorkspaces conn idUsuario
    putStrLn("\n")
    print l
    menuUsuario conn idUsuario