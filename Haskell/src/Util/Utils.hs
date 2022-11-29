module Util.Utils (
        telaInicial,
        telaCadastro,
        telaEncerramento,
        lerEntrada
) where

telaInicial :: String
telaInicial = (tituloInical) ++ (tituloEscolha) ++ (menuInicial)

telaCadastro :: String
telaCadastro = (tituloCadastro) ++ (tituloEscolha) ++ (menuCadastro)

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
        ++ "            Cadastro              \n"
        ++ " -------------------------------- \n"

menuCadastro :: String
menuCadastro = "\n" 
        ++ " ------------------------ \n"
        ++ "  1 - Cadastrar           \n"
        ++ "  2 - Encerrar programa   \n"
        ++ " ------------------------ \n"

tituloEscolha :: String
tituloEscolha = "\n"
        ++ "Escolha uma opção:\n"

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