{-# LANGUAGE OverloadedStrings #-}
module LocalDB.WorkspaceDB where
import Database.PostgreSQL.Simple
    ( connect,
      defaultConnectInfo,
      execute_,
      ConnectInfo(connectHost, connectDatabase, connectUser,
                  connectPassword, connectPort),
      Connection )

createWorkspaces :: Connection -> IO()
createWorkspaces conn = do
    execute_ conn "CREATE TABLE IF NOT EXISTS workspace(\
                    \workspace_id SERIAL PRIMARY KEY,\
                    \workspace_nome TEXT NOT NULL,\
                    \usuario_id SERIAL NOT NULL REFERENCES usuario (usuario_id) ON DELETE CASCADE);"
    return ()

createWorkspaceUsuarios :: Connection -> IO()
createWorkspaceUsuarios conn = do
    execute_ conn "CREATE TABLE IF NOT EXISTS workspace_colaboradores(\
                    \workspace_id SERIAL NOT NULL REFERENCES workspace (workspace_id) ON DELETE CASCADE,\
                    \usuario_id SERIAL NOT NULL REFERENCES usuario (usuario_id) ON DELETE CASCADE,\
                    \PRIMARY KEY (workspace_id, usuario_id));"
    return ()

createWorkspaceAreas :: Connection -> IO()
createWorkspaceAreas conn = do
    execute_ conn "CREATE TABLE IF NOT EXISTS workspace_areas(\
                    \area_id SERIAL PRIMARY KEY,\
                    \workspace_id SERIAL NOT NULL REFERENCES workspace (workspace_id),\
                    \area_nome TEXT NOT NULL);"
    return ()

createWorkspaceTarefas :: Connection -> IO()
createWorkspaceTarefas conn = do
    execute_ conn "CREATE TABLE IF NOT EXISTS workspace_tarefas(\
                    \tarefa_id SERIAL PRIMARY KEY,\
                    \workspace_id SERIAL NOT NULL REFERENCES workspace (workspace_id),\
                    \area_id SERIAL NOT NULL REFERENCES workspace_areas (area_id),\
                    \tarefa_nome TEXT NOT NULL,\
                    \tarefa_info TEXT,\
                    \tarefa_estado TEXT NOT NULL,\
                    \tarefa_prioridade TEXT NOT NULL);"
    return ()
