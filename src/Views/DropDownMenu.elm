module Views.DropDownMenu exposing (dropDownMenu)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models.Model exposing (..)
import Models.Types exposing (..)


dropDownMenu : Model -> Html Msg
dropDownMenu model =
    div [ class "dropDownMenu", class (dropDownMenuDisplay model.burgerStatus) ]
        [ ul [ class "menuList" ]
            [ li [] [ button [ class "dropDownMenyButton" ] [ text "Statistics" ] ]
            , li [] [ button [ class "dropDownMenyButton" ] [ text "Graphs" ] ]
            , li [] [ button [ class "dropDownMenyButton" ] [ text "About" ] ]
            ]
        ]


dropDownMenuDisplay : BurgerStatus -> String
dropDownMenuDisplay burgerStatus =
    case burgerStatus of
        Open ->
            "open"

        Closed ->
            "closed"
