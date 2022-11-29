module Menu.Sistema where

import Controller.UsuarioController

import Database.PostgreSQL.Simple ( Connection )

ehUsuario :: Connection -> String -> String -> IO Int
ehUsuario conn login senha = verificarUsuario conn login senha