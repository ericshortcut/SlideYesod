{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE ViewPatterns          #-}

import Yesod
import Data.Text

data Eco = Eco
data Mensagem = Mensagem Text deriving Show

mkYesod "Eco" [parseRoutes|
/                   HomeR                   GET
/mensagem/#Text     MensagemR         GET
!/mensagem          MensagemVazia     GET

|]

instance Yesod Eco where
    errorHandler NotFound =  mensagemDeErro "Página não encontrada"
    errorHandler other = defaultErrorHandler other

mensagemDeErro :: Text -> HandlerT Eco IO TypedContent
mensagemDeErro x = fmap toTypedContent $ defaultLayout $ toWidget $ 
                [hamlet| Erro --> #{x} |]

getHomeR :: Handler Html
getHomeR = defaultLayout [whamlet|
    <h1>Olá Mundo!
    <p> Lorem ipsum dolor sit amet, consectetur adipisicing elit.
    |]


getMensagemR :: Text -> Handler Html
getMensagemR msg = montarMensagem msg

getMensagemVazia :: Handler Html
getMensagemVazia = getMensagemR empty

--- Helper
montarMensagem :: Text -> Handler Html
montarMensagem "" = montarMensagem "woops"
montarMensagem t = defaultLayout $ toWidget $ [hamlet| <p> Mensagem: #{ t } |]


main :: IO ()
main = warp 3000 Eco