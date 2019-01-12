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
            [ li [] [ button [ class "dropDownMenyButton", onClick (GoToPage Years) ] [ text "Hobby Journal" ] ]
            , li [] [ button [ class "dropDownMenyButton", onClick (GoToPage Statistics) ] [ text "Statistics" ] ]
            , li [] [ button [ class "dropDownMenyButton", onClick (GoToPage Graphs) ] [ text "Graphs" ] ]
            , li [] [ button [ class "dropDownMenyButton", onClick (GoToPage About) ] [ text "About" ] ]
            ]
        ]


dropDownMenuDisplay : BurgerStatus -> String
dropDownMenuDisplay burgerStatus =
    case burgerStatus of
        Open ->
            "dropDownOpen"

        Closed ->
            "dropDownClosed"
