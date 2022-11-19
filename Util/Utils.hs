module Haskell.Util.Utils (
        telaInicial
) where

telaInicial :: String -> String
telaInicial str = str ++ (tituloInical "") ++ (tituloEscolha "") ++ (menuInicial "")

menuInicial :: String -> String
menuInicial str = str ++ "\n" 
        ++ " ------------------------\n"
        ++ "  1 - Fazer Login        \n"
        ++ "  2 - Fazer cadastro     \n"
        ++ "  3 - Encerrar programa  \n"
        ++ " ------------------------\n"

tituloInical :: String -> String
tituloInical str = str ++ "\n"
            ++ " --------------------------------\n"
            ++ "   Gerenciador de Tarefas Kaban  \n"
            ++ " --------------------------------\n"

tituloEscolha :: String -> String
tituloEscolha str = str ++ "\n"
            ++ "  Escolha uma opção:  \n"