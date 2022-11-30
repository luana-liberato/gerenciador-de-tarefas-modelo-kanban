{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use join" #-}

module Controller.UsuarioController where
import Database.PostgreSQL.Simple ( Connection, execute, query, QueryError (qeMessage), execute_ )
import Model.Usuario
import LocalDB.ConnectionDB
import Database.PostgreSQL.Simple.Types
import GHC.IO

criarUsuario :: Connection -> String -> String -> String -> IO()
criarUsuario conn nome login senha = do
    let query = "insert into usuario (usuario_nome,\
                                     \usuario_login,\
                                     \usuario_senha) values (?,?,?)"
    execute conn query (nome, login, senha)
    return ()

removerUsuario :: Connection -> Int -> IO Bool
removerUsuario conn id = do
    n <- execute conn "DELETE FROM usuario WHERE usuario_id = ?" $ Only id
    return $ n > 0

getUsuarioPorLogin :: String -> [Usuario]
getUsuarioPorLogin login = do
    let q = "select * from usuario where usuario_login = '" ++ login ++ "'"
    unsafePerformIO (queryDB q)

verificarUsuario :: Connection -> String -> String -> IO Int
verificarUsuario conn l s = do
    let user = getUsuarioPorLogin l

    if (user == []) then
        return (-404)

    else if (s == (senha (head user))) then
        return (idUsuario (head user))
        
    else
        return (-401)

-- existeUsuario :: String -> Bool
-- existeUsuario login = FalseS