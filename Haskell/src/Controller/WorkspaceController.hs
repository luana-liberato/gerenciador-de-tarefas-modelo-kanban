{-# LANGUAGE OverloadedStrings #-}

module Controller.WorkspaceController where
import Database.PostgreSQL.Simple ( Connection, execute, query, Only (..), query_ )
import Data.Int
import Model.Workspace
import Model.Usuario
import Model.Tarefa
import Model.Area

criarWorkspace :: Connection -> String -> Int -> IO Int
criarWorkspace conn nome idUsuario = do

    wid <- query conn "INSERT INTO workspace (workspace_nome, usuario_id) VALUES (?, ?) RETURNING workspace_id" (nome, idUsuario) :: IO [Only Int64]
    let workid = fromIntegral (fromOnly (head wid)) :: Int

    return workid

getWorkspaces :: Connection -> Int -> IO [Workspace]
getWorkspaces conn usuarioId = do
    query conn "SELECT workspace_id, workspace_nome FROM workspace w WHERE w.usuario_id = ?" $ (Only usuarioId) :: IO [Workspace]

