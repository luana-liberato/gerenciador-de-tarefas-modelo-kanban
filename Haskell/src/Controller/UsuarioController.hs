{-# LANGUAGE OverloadedStrings #-}

module Controller.UsuarioController where
import Database.PostgreSQL.Simple ( Connection, execute )

cadastrarUsuario :: Connection -> String -> String -> String -> IO ()
cadastrarUsuario conn nome login senha = do
    let query = "insert into usuario (usuario_nome,\
                                     \usuario_login,\
                                     \usuario_senha) values (?,?,?)"
    execute conn query (nome, login, senha)
    return ()
