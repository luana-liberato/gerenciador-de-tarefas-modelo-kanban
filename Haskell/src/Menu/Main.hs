{-# LANGUAGE OverloadedStrings #-}
module Main where
import Util.Utils ( telaInicial, telaCadastro, telaEncerramento, lerEntrada )
import Database.PostgreSQL.Simple ()
import LocalDB.ConnectionDB

import System.IO (utf8, hSetEncoding, stdout)
import Controller.UsuarioController
import Controller.WorkspaceController

main :: IO()
main = do
    hSetEncoding stdout utf8
    conn <- iniciandoDatabase

    menuPrincipal
    --return()

-------- Menu Principal --------
menuPrincipal :: IO()
menuPrincipal = do
    putStrLn(telaInicial)

    opc <- lerEntrada
    opcaoMenuPrincipal opc


opcaoMenuPrincipal :: String -> IO()
opcaoMenuPrincipal opcao | (opcao == "1") = menuCadastro
                         | (opcao == "2") = menuLogin
                         | (opcao == "3") = telaEncerramento
                         | otherwise = menuPrincpal

-------- Cadastro de Usuário --------
menuCadastro :: IO()
menuCadastro = do
    putStrLn(telaCadastro)

    opc <- lerEntrada
    opcaoMenuCadastro opc

opcaoMenuCadastro :: String -> IO()
opcaoMenuCadastro opcao | (opcao == "1") = cadastro
                        | (opcao == "2") = telaEncerramento
                        | otherwise = menuCadastro

cadastro :: IO()
cadastro = do
    putStrLn(telaCadastro)

    putStrLn("Informe o seu nome completo:\n")
    nome <- lerEntrada

    -- Tem que fazer as validações do login
    putStrLn("Crie um login para identificação:\n")
    login <- lerEntrada

    putStrLn("Crie uma senha para acesso:\n")
    senha <- lerEntrada

    