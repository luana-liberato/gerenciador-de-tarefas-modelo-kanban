module Menu.Sistema where

import Controller.UsuarioController
import Controller.WorkspaceController
import Controller.TarefaController
import Database.PostgreSQL.Simple ( Connection )
import Model.Workspace

ehUsuario :: Connection -> String -> String -> IO Int
ehUsuario conn login senha = verificarUsuario conn login senha

cadastroUsuario :: Connection -> String -> String -> String -> IO()
cadastroUsuario conn nome login senha = do
    criarUsuario conn nome login senha
    return()

cadastroWorkspace :: Connection -> String -> Int -> IO()
cadastroWorkspace conn nome idUsuario = do
    criarWorkspace conn nome idUsuario
    return()

listarWorkspaces :: Connection -> Int -> IO [Workspace]
listarWorkspaces conn idUsuario = do
    getWorkspaces conn idUsuario

cadastroTarefa :: Connection -> Int -> Int -> String -> String -> String -> Int -> IO [Workspace]
cadastroTarefa conn workspaceId areaId nome info estado prioridade = do
    criarTarefa conn workspaceId areaId nome info estado prioridade

listarTarefas :: Connection -> Int -> IO [Workspace]
listarTarefas conn workspaceId = do
    getTarefas conn workspaceId

