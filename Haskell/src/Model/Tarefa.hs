module Model.Tarefa where

data Tarefa = Tarefa {

    id :: Int,
    nome :: String,
    estado :: String,
    informacoes :: String,
    prioridade :: Int,
    idWorkspace :: Int,
    idArea :: Int

}