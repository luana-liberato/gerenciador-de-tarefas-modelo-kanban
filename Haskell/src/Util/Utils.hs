module Util.Utils (
        telaInicial,
        telaCadastro,
        telaLogin,
        lerEntrada
) where

telaInicial :: String
telaInicial = (tituloInical) ++ (tituloEscolha) ++ (menuInicial)

telaCadastro :: String
telaCadastro = (tituloCadastro) ++ (tituloEscolha) ++ (menuCadastro)

telaLogin :: String
telaLogin = (tituloLogin) ++ (tituloEscolha) ++ (menuLogin)

tituloInical :: String
tituloInical = "\n"
        ++ " -------------------------------- \n"
        ++ "   Gerenciador de Tarefas Kaban   \n"
        ++ " -------------------------------- \n"

menuInicial :: String
menuInicial = "\n" 
        ++ " ------------------------ \n"
        ++ "  1 - Fazer Login         \n"
        ++ "  2 - Fazer cadastro      \n"
        ++ "  3 - Encerrar programa   \n"
        ++ " ------------------------ \n"

tituloCadastro :: String
tituloCadastro = "\n"
        ++ " -------------------------------- \n"
        ++ "            CADASTRO              \n"
        ++ " -------------------------------- \n"

menuCadastro :: String
menuCadastro = "\n" 
        ++ " ----------------------------- \n"
        ++ "  1 - Cadastrar                \n"
        ++ "  2 - Voltar ao menu inicial   \n"
        ++ " ----------------------------- \n"

tituloLogin :: String
tituloLogin = "\n"
        ++ " -------------------------------- \n"
        ++ "              LOGIN               \n"
        ++ " -------------------------------- \n"
        
menuLogin :: String
menuLogin = "\n" 
        ++ " ----------------------------- \n"
        ++ "  1 - Login                    \n"
        ++ "  2 - Voltar ao menu inicial   \n"
        ++ " ----------------------------- \n"

tituloEscolha :: String
tituloEscolha = "\n"
        ++ " Escolha uma opção:\n"

telaEncerramento :: String
telaEncerramento = "\n"
        ++ " -------------------------------- \n"
        ++ "   Gerenciador de Tarefas Kaban   \n"
        ++ " -------------------------------- \n"
        ++ "            ECERRANDO...          \n"

lerEntrada :: IO String
lerEntrada = do
        ent <- getLine
        return ent