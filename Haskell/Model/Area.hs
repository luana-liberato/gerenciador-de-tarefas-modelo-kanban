data Area = Area {
    id :: Int,
    nome :: String,
    idResponsavel :: Int, -- Mais de uma pessoa pode ser responsável pela área
    idWorkspace :: Int
}