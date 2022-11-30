module Menu.Sistema where

import Controller.UsuarioController
import Controller.WorkspaceController
import Database.PostgreSQL.Simple ( Connection )

ehUsuario :: Connection -> String -> String -> IO Int
ehUsuario conn login senha = verificarUsuario conn login senha

cadastroUsuario :: Connection -> String -> String -> String -> IO()
cadastroUsuario conn nome login senha = do
    criarUsuario conn nome login senha
    return()

cadastroWorkspace :: Connection -> String -> Int -> IO()
cadastroWorkspace conn nome idUsuario = do
    criarWorkspace conn nome idUsuario
    return()