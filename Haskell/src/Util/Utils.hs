module Util.Utils (
        telaInicial,
        telaCadastro
) where

telaInicial :: String
telaInicial = (tituloInical) ++ (tituloEscolha) ++ (menuInicial)

telaCadastro :: String
telaCadastro = (tituloCadastro) ++ (tituloEscolha) ++ (menuCadastro)

tituloInical :: String
tituloInical = "\n"
        ++ " --------------------------------\n"
        ++ "   Gerenciador de Tarefas Kaban  \n"
        ++ " --------------------------------\n"

menuInicial :: String
menuInicial = "\n" 
        ++ " ------------------------\n"
        ++ "  A - Fazer Login        \n"
        ++ "  B - Fazer cadastro     \n"
        ++ "  C - Encerrar programa  \n"
        ++ " ------------------------\n"

tituloCadastro :: String
tituloCadastro = "\n"
        ++ " ------------\n"
        ++ "   Cadastro  \n"
        ++ " ------------\n"

menuCadastro :: String
menuCadastro = "\n" 
        ++ " ------------------------\n"
        ++ "  A - Para cadastrar     \n"
        ++ "  B - Encerrar programa  \n"
        ++ " ------------------------\n"

tituloEscolha :: String
tituloEscolha = "\n"
        ++ "Escolha uma opção:\n"