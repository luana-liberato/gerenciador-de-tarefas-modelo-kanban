{-# LANGUAGE FlexibleInstances #-}
module Model.Workspace where

import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.FromField
import qualified Data.ByteString.Char8 as C

data Workspace = Workspace {

    idWorkspace :: Int,
    nome :: String

} deriving Read

instance Show Workspace where
    show (Workspace idWorkspace nome) = "Workspace " ++ nome ++ " id: " ++ show (idWorkspace) ++ "\n"

stringToWorkspaces:: String -> [Workspace]
stringToWorkspaces json_agg = do
    let listaStrings = read json_agg :: [String]
    map stringToWorkspace listaStrings
    
stringToWorkspace :: String -> Workspace
stringToWorkspace query = read query :: Workspace

instance FromRow Workspace where
    fromRow = Workspace <$> field
                        <*> field

instance FromField [Workspace] where
    fromField f bs = do
        case bs of
            Nothing -> returnError UnexpectedNull f ""
            Just bs -> return (stringToWorkspaces (C.unpack bs))