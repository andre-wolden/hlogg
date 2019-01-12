module Views.About exposing (viewAbout)

import Html exposing (Html, br, button, div, i, img, li, p, text, ul)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models.Model exposing (Model)
import Models.Types exposing (Page(..))


viewAbout : Model -> Html Msg
viewAbout model =
    div [] [ text "About" ]
