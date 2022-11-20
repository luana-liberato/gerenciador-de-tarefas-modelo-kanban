module Model.Usuario where

import Database.PostgreSQL.Simple
import Model.Workspace

data Usuario = Usuario {
    id :: Int,
    nome :: String,
    login :: String,
    senha :: String,
    workspaces :: [Workspace]
} deriving (Show, Read, Eq)

instance FromRow Usuario where
    fromRow = Usuario <$> field
                      <*> field
                      <*> field
                      <*> field
                      <*> field