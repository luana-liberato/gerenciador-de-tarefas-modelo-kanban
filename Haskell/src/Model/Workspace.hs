module Model.Workspace where

import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.FromField

data Workspace = Workspace {

    id :: Int,
    nome :: String

}

instance FromRow Workspace where
    fromRow = Workspace <$> field
                        <*> field