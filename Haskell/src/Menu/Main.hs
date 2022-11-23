module Main where
import Util.Utils ( telaInicial, telaCadastro )

import System.IO (utf8, hSetEncoding, stdout)

main :: IO()
main = do
    hSetEncoding stdout utf8
    putStrLn(telaInicial)