{-# LANGUAGE OverloadedStrings #-}
module LocalDB.ConnectionDB where
import Database.PostgreSQL.Simple
    ( connect,
      defaultConnectInfo,
      execute_,
      ConnectInfo(connectHost, connectDatabase, connectUser,
                  connectPassword, connectPort),
      Connection )

import LocalDB.UsuarioDB
import LocalDB.WorkspaceDB

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
        return c