{-# LANGUAGE FlexibleInstances #-}

module Model.Usuario where

import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.FromField

import qualified Data.ByteString.Char8 as C

data Usuario = Usuario {

    idUsuario :: Int,
    nome :: String,
    login :: String,
    senha :: String

} deriving (Read, Show, Eq)

stringToUsuarios:: String -> [Usuario]
stringToUsuarios json_agg = do
    let listaStrings = read json_agg :: [String]
    map stringToUsuario listaStrings
    
stringToUsuario :: String -> Usuario
stringToUsuario query = read query :: Usuario

instance FromRow Usuario where
    fromRow = Usuario <$> field
                      <*> field
                      <*> field
                      <*> field

instance FromField [Usuario] where
    fromField f bs = do
        case bs of
            Nothing -> returnError UnexpectedNull f ""
            Just bs -> return (stringToUsuarios (C.unpack bs))