{-# LANGUAGE OverloadedStrings #-}

module Controller.WorkspaceController where
import Database.PostgreSQL.Simple ( Connection, execute, query, Only (..), query_ )
import Data.Int
import Model.Workspace
import Model.Usuario
import Model.Tarefa
import Model.Area

criarTarefa :: Connection -> Int -> Int -> String -> String -> String -> Int -> IO Int
criarTarefa conn workspaceId areaId nome info estado prioridade = do

    wid <- query conn "INSERT INTO workspace_tarefas (workspace_id, 
    area_id,tarefa_nome,tarefa_info,tarefa_estado,tarefa_prioridade) VALUES (?, ?, ?, ?, ?, ?) RETURNING workspace_id" (wordspaceId, areaId, nome, info, estado, prioridade) :: IO [Only Int64]
    let workid = fromIntegral (fromOnly (head wid)) :: Int
 
    return workid

getTarefas :: Connection -> Int -> IO [Workspace]
getTarefas conn workspaceId = do
    query conn "SELECT tarefa_nome, tarefa_info, tarefa_estado, tarefa_prioridade FROM workspace_tarefas w WHERE w.workspace_id = ?" $ (Only workspaceId) :: IO [Workspace]

