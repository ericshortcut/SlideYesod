{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}

import           Yesod

data OlaMundo = OlaMundo

mkYesod "OlaMundo" [parseRoutes|
/ HomeR GET
|]

instance Yesod OlaMundo

getHomeR :: Handler Html
getHomeR = defaultLayout $ do
    setTitle "Bem vindo ao Yesod!"
    [whamlet|
        <h1>Olá Mundo!
        <p> Lorem ipsum dolor sit amet, consectetur adipisicing elit.
    |]

main :: IO ()
main = warp 3000 OlaMundo