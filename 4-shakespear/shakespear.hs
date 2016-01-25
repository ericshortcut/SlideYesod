{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}
import           Yesod
import qualified Data.Text as TS
import           Text.Hamlet
import           Text.Lucius
import           Text.Cassius
import           Text.Julius

data Shakespear = Shakespear
mkYesod "Shakespear" [parseRoutes|
/ HomeR GET
/bue BlueR GET
/red RedR GET
|]

meuLayout :: Widget -> Handler Html
meuLayout widget = do
    pc <- widgetToPageContent widget
    withUrlRenderer
        $(hamletFile "templates/default-base.hamlet")

instance Yesod Shakespear where
    defaultLayout = meuLayout


getHomeR ::  Handler Html
getHomeR = pagina "Principal" [whamlet| <h1>Principal|]

getRedR :: Handler Html
getRedR = pagina "Red" [whamlet| <h1>Red|]

getBlueR :: Handler Html
getBlueR = pagina "Blue" [whamlet| <h1>Blue|]


pagina :: Html  -> Widget -> Handler Html
pagina title widget = defaultLayout $ do
                face <- newIdent
                setTitle title
                header >> nav >> widget >> (footer face) >> cssCassius >> cssLucius >> (jsJulius)
      
header :: Widget
header = toWidget [hamlet|
    <header>
        <h1>Header
|]

nav :: Widget
nav  = toWidget [hamlet|
    <ul>
      <li>
        <a href=@{HomeR}> Home
      <li>
        <a href=@{BlueR}> Blue
      <li>
        <a href=@{RedR}> Red
|]


footer :: TS.Text -> Widget
footer face =  [whamlet|
    <footer class=footer>
      Footer 
        <i id=#{ face }>:)        
|]

cssCassius :: Widget
cssCassius = toWidget $( cassiusFile "templates/home.cassius")
        where
            bgColor :: TS.Text
            bgColor = "#F00"


cssLucius :: Widget
cssLucius = toWidget $( luciusFile "templates/home.lucius")

jsJulius ::  Widget
jsJulius  = toWidgetBody $( juliusFile "templates/home.julius")

main :: IO ()
main = warp 3000 Shakespear