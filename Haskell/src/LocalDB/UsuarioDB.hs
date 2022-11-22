{-# LANGUAGE OverloadedStrings #-}
module LocalDB.UsuarioDB where
import Database.PostgreSQL.Simple
    ( connect,
      defaultConnectInfo,
      execute_,
      ConnectInfo(connectHost, connectDatabase, connectUser,
                  connectPassword, connectPort),
      Connection )

createUsuarios :: Connection -> IO()
createUsuarios conn = do
    execute_ conn "CREATE TABLE IF NOT EXISTS usuario(\
                    \usuario_id SERIAL PRIMARY KEY,\
                    \usuario_nome TEXT NOT NULL,\
                    \usuario_login TEXT NOT NULL,\
                    \usuario_senha TEXT NOT NULL);"
    return ()