{-# LANGUAGE OverloadedStrings #-}

module Controller.WorkspaceController where
import Database.PostgreSQL.Simple ( Connection, execute )

criarWorkspace :: Connection -> String -> Int -> IO ()
criarWorkspace conn nome idUsuario = do
    let query = "insert into workspace (workspace_nome, usuario_id, is_admin) values (?,?,?)"
    execute conn query (nome, idUsuario, True)
    return ()