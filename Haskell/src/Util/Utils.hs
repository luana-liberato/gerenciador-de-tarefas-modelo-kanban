module Util.Utils (
        telaInicial,
        telaCadastro,
        telaLogin,
        telaEncerramento,
        telaUsuario,
        tituloWorkspace,
        tituloParaFazer,
        tituloEmAndamento,
        tituloFeitas,
        telaMenuWorkspace,
        lerEntrada
) where

telaInicial :: String
telaInicial = (tituloInicial) ++ (tituloEscolha) ++ (menuInicial)

telaCadastro :: String
telaCadastro = (tituloCadastro) ++ (tituloEscolha) ++ (menuCadastro)

telaLogin :: String
telaLogin = (tituloLogin) ++ (tituloEscolha) ++ (menuLogin)

telaUsuario :: String
telaUsuario = (tituloInicial) ++ (tituloEscolha) ++ (menuUsuario)

telaMenuWorkspace :: String
telaMenuWorkspace = (menuWorkspace) ++ (tituloEscolha)

tituloInicial :: String
tituloInicial = "\n"
        ++ "--------------------------------\n"
        ++ "  Gerenciador de Tarefas Kaban  \n"
        ++ "--------------------------------\n"

menuInicial :: String
menuInicial = "\n" 
        ++ "------------------------\n"
        ++ " 1 - Fazer Login        \n"
        ++ " 2 - Fazer cadastro     \n"
        ++ " 3 - Encerrar programa  \n"
        ++ "------------------------\n"

tituloCadastro :: String
tituloCadastro = "\n"
        ++ "--------------------------------\n"
        ++ "           CADASTRO             \n"
        ++ "--------------------------------\n"

menuCadastro :: String
menuCadastro = "\n" 
        ++ "-----------------------------\n"
        ++ " 1 - Cadastrar               \n"
        ++ " 2 - Voltar ao menu inicial  \n"
        ++ "-----------------------------\n"

tituloLogin :: String
tituloLogin = "\n"
        ++ "--------------------------------\n"
        ++ "             LOGIN              \n"
        ++ "--------------------------------\n"
        
menuLogin :: String
menuLogin = "\n" 
        ++ "-----------------------------\n"
        ++ " 1 - Login                   \n"
        ++ " 2 - Voltar ao menu inicial  \n"
        ++ "-----------------------------\n"
                
menuUsuario :: String
menuUsuario = "\n" 
        ++ "----------------------------\n"
        ++ " 1 - Criar Workspace        \n"
        ++ " 2 - Visualizar Workspaces  \n"
        ++ " 3 - Acessar Workspace      \n"
        ++ " 4 - Sair                   \n"
        ++ "----------------------------\n"

tituloWorkspace :: String
tituloWorkspace = "\n"
        ++ "----------------------------------\n"
        ++ "            WORKSPACE             \n"
        ++ "----------------------------------\n"

menuWorkspace :: String
menuWorkspace = "\n" 
        ++ "-----------------------------------\n"
        ++ " 1 - Criar tarefa                  \n"
        ++ " 2 - Alterar status de uma tarefa  \n"
        ++ " 3 - Sair da Workspace             \n"
        ++ "-----------------------------------\n"

tituloEscolha :: String
tituloEscolha = "\n"
        ++ "Escolha uma opção:\n"

telaEncerramento :: String
telaEncerramento = "\n"
        ++ "--------------------------------\n"
        ++ "  Gerenciador de Tarefas Kaban  \n"
        ++ "--------------------------------\n"
        ++ "          ENCERRANDO...         \n"

tituloParaFazer :: String
tituloParaFazer = "\n"
        ++ "--------------------------------\n"
        ++ "       TAREFAS PARA FAZER       \n"
        ++ "--------------------------------\n"

tituloEmAndamento :: String
tituloEmAndamento = "\n"
        ++ "--------------------------------\n"
        ++ "      TAREFAS EM ANDAMENTO      \n"
        ++ "--------------------------------\n"

tituloFeitas :: String
tituloFeitas = "\n"
        ++ "--------------------------------\n"
        ++ "       TAREFAS FINALIZADAS      \n"
        ++ "--------------------------------\n"

lerEntrada :: IO String
lerEntrada = do
        ent <- getLine
        return ent