{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use join" #-}

module Controller.UsuarioController where
import Database.PostgreSQL.Simple ( Connection, execute, query, QueryError (qeMessage), execute_ )
import Model.Usuario
import LocalDB.ConnectionDB
import Database.PostgreSQL.Simple.Types
import GHC.IO

cadastrarUsuario :: Connection -> String -> String -> String -> IO ()
cadastrarUsuario conn nome login senha = do
    let query = "insert into usuario (usuario_nome,\
                                     \usuario_login,\
                                     \usuario_senha) values (?,?,?)"
    execute conn query (nome, login, senha)
    return ()

getUsuarioByLogin :: String -> [Usuario]
getUsuarioByLogin login = do
    let q = "select * from usuario where usuario_login = '" ++ login ++ "'"
    unsafePerformIO (queryDB q)

removerUsuario :: Connection -> Int -> IO Bool
removerUsuario conn id = do
    n <- execute conn "DELETE FROM usuario WHERE usuario_id = ?" $ Only id
    return $ n > 0


isUsuario :: String -> Bool
isUsuario login = False