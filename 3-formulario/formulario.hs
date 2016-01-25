{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE MultiParamTypeClasses #-}

import Yesod
import Data.Text
import Control.Applicative((<$>),(<*>))


data Formulario = Formulario
data Mensagem = Mensagem { conteudo::Text }


mkYesod "Formulario" [parseRoutes|
/ HomeR GET POST
|]

instance Yesod Formulario where


type Form a = Html -> MForm Handler (FormResult a, Widget)


getHomeR :: Handler Html
getHomeR = do
             (widget, enctype) <- generateFormPost $ formMensagem (Just "Mensagem Padrão")
             defaultLayout $ widgetForm HomeR enctype widget "Mensagems"

postHomeR :: Handler Html
postHomeR = do
            ( ( resultado , _ ) , _ ) <- runFormPost $ formMensagem Nothing
            (widget, enctype) <- generateFormPost $ formMensagem (Just "Mensagem Padrão")
            case resultado of
                FormSuccess msg -> defaultLayout $
                                    [whamlet|<h1><i> #{ conteudo msg } |] >>
                                     widgetForm HomeR enctype widget "Mensagems"
                _ -> redirect HomeR



formMensagem :: Maybe Text -> Form Mensagem
formMensagem msg = renderDivs $ Mensagem 
                   <$> areq textField "Mensagem" msg

widgetForm :: Route Formulario -> Enctype -> Widget -> Text -> Widget
widgetForm action enctype widget titulo = [whamlet|
            <h1> #{titulo}
            <form method=post action=@{action} enctype=#{enctype}>
                ^{widget}
                <input type="submit" value="Enviar">
|]


instance RenderMessage Formulario FormMessage where
    renderMessage _ _ = defaultFormMessage



main :: IO ()
main = warp 3000 Formulario