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
                    \workspace_id SERIAL NOT NULL,\
                    \workspace_nome TEXT NOT NULL,\
                    \usuario_id SERIAL NOT NULL,\
                    \is_admin BOOLEAN NOT NULL DEFAULT FALSE,\
                    \PRIMARY KEY (workspace_id, usuario_id));"
    return ()
