{-# LANGUAGE OverloadedStrings #-}
module LocalDB.ConnectionDB where
import Database.PostgreSQL.Simple
    ( connect,
      defaultConnectInfo,
      execute_,
      ConnectInfo(connectHost, connectDatabase, connectUser,
                  connectPassword, connectPort),
      Connection, query_ )

import LocalDB.UsuarioDB
import LocalDB.WorkspaceDB
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.Types

localDB:: ConnectInfo
localDB = defaultConnectInfo {
    connectHost = "localhost",
    connectDatabase = "kanban_app",
    connectUser = "postgres",
    connectPassword = "mateus123",
    connectPort = 5432
}

connectionMyDB :: IO Connection
connectionMyDB = connect localDB
iniciandoDatabase :: IO Connection
iniciandoDatabase = do
        c <- connectionMyDB
        createUsuarios c
        createWorkspaces c
        createWorkspaceUsuarios c
        createWorkspaceAreas c
        createWorkspaceTarefas c
        return c

queryDB :: FromRow r => String -> IO [r]
queryDB query = do
   conn <- connectionMyDB
   let q = read $ show query :: Query;
   query_ conn q;