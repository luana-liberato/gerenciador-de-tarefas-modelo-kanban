module Model.Usuario where

import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.FromField

data Usuario = Usuario {

    id :: Int,
    nome :: String,
    login :: String,
    senha :: String

}

instance FromRow Usuario where
    fromRow = Usuario <$> field
                      <*> field
                      <*> field
                      <*> field