module Model.Workspace where

data Workspace = Workspace {

    id :: Int,
    nome :: String,
    pessoas :: [(Usuario, Bool)]

}