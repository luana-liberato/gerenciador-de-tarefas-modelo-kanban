{-# LANGUAGE OverloadedStrings #-}
module LocalDB.ConnectionDB where
import Database.PostgreSQL.Simple
    ( connect,
      defaultConnectInfo,
      execute_,
      ConnectInfo(connectHost, connectDatabase, connectUser,
                  connectPassword, connectPort),
      Connection )

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

createUsuarios :: Connection -> IO()
createUsuarios conn = do
    execute_ conn "CREATE TABLE IF NOT EXISTS usuario(\
                    \usuario_id SERIAL PRIMARY KEY,\
                    \usuario_nome VARCHAR(25) NOT NULL,\
                    \usuario_login VARCHAR(10) NOT NULL,\
                    \usuario_senha VARCHAR(10) NOT NULL);"
    return ()

iniciandoDatabase :: IO Connection
iniciandoDatabase = do
        c <- connectionMyDB
        createUsuarios c
        return c