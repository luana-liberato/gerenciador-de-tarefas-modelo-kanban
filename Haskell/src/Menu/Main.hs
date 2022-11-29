{-# LANGUAGE OverloadedStrings #-}
module Main where
import Menu.Sistema
import Util.Utils ( telaInicial, telaCadastro, telaLogin, lerEntrada )
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
    --return()

-------- Menu Principal --------
menuPrincipal :: Connection -> IO()
menuPrincipal conn = do
    putStrLn(telaInicial)

    opc <- lerEntrada
    opcaoMenuPrincipal conn opc


opcaoMenuPrincipal :: Connection -> String -> IO()
opcaoMenuPrincipal conn opcao | (opcao == "1") = menuLogin conn
                              | (opcao == "2") = menuCadastro conn
                             -- | (opcao == "3") = print telaEncerramento
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

    putStrLn("\n Informe o seu nome completo:\n")
    nome <- lerEntrada

    -- Tem que fazer as validações do login
    putStrLn("\n Crie um login para identificação:\n")
    login <- lerEntrada

    putStrLn("\n Crie uma senha para acesso:\n")
    senha <- lerEntrada

    cadastrarUsuario conn nome login senha

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

    putStrLn("\n Informe o seu login:\n")
    login <- lerEntrada

    putStrLn("\n Informe sua senha:\n")
    senha <- lerEntrada

    num <- ehUsuario conn login senha

    if (num == -404) then do
        putStrLn(" USUÁRIO NÃO ENCONTRADO!")
        menuLogin conn
    
    else if (num == -401) then do
        putStrLn(" SENHA INCORRETA!")
        menuLogin conn

    else do
        putStrLn(" DEU CERTO!")