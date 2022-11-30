{-# LANGUAGE OverloadedStrings #-}

module Controller.WorkspaceController where
import Database.PostgreSQL.Simple ( Connection, execute, query, Only (..) )
import Data.Int
import Model.Workspace
import Model.Usuario
import Model.Tarefa
import Model.Area

criarWorkspace :: Connection -> String -> Int -> IO()
criarWorkspace conn nome idUsuario = do

    -- wid <- 
    let query = "INSERT INTO workspace (workspace_nome, usuario_id) VALUES (?, ?)" 
    execute conn query (nome, idUsuario)
    
    -- RETURNING workspace_id" (nome, idUsuario) :: IO [Only Int64]
    -- let workid = fromIntegral (fromOnly (head wid)) :: Int

    return ()

getWorkspacePorIdUsuario :: String -> [Workspace]
getWorkspacePorIdUsuario login = do
    let q = "select * from workspace where usuario_login = '" ++ login ++ "'"
    unsafePerformIO (queryDB q)

getWorkspaces :: Connection -> String -> [Workspace]
getWorkspaces conn idUsuario = do
    let listaWorkspaces = getWorkspacePorIdUsuario idUsuario

    return listaWorkspaces

