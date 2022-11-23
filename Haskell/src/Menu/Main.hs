{-# LANGUAGE OverloadedStrings #-}
module Main where
import Util.Utils ( telaInicial )
import Database.PostgreSQL.Simple ()
import LocalDB.ConnectionDB

import System.IO (utf8, hSetEncoding, stdout)
import Controller.UsuarioController
import Controller.WorkspaceController

main :: IO()
main = do
    hSetEncoding stdout utf8
    putStrLn(telaInicial "")
    putStrLn "Criando base de dados..."
    conn <- iniciandoDatabase
    putStrLn "Base de dados criada"
    return()
    