module Views.ViewWeek exposing (insertDay, insertWeekView)

import Html exposing (Html, br, button, div, i, img, li, p, text, ul)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models.Model exposing (Model)
import Models.Types exposing (Page(..))


insertWeekView : Model -> Int -> Int -> Html Msg
insertWeekView model year week =
    div [ class "week" ]
        [ div [ class "weekHeader" ]
            [ button [ class "backArrow", onClick (GoToYear year) ] [ i [ class "fas fa-angle-left" ] [] ]
            , div [ class "weekTitle" ] [ text (Debug.toString year ++ ", Week " ++ Debug.toString week) ]
            ]
        , ul [ class "weekBody" ]
            [ li []
                [ div [] [ text "Monday" ]
                , insertDay model year week 1
                ]
            , li [] [ text "Tuesday" ]
            , li [] [ text "Wednesday" ]
            , li [] [ text "Thursday" ]
            , li [] [ text "Friday" ]
            , li [] [ text "Saturday" ]
            , li [] [ text "Sunday" ]
            ]
        ]


insertDay : Model -> Int -> Int -> Int -> Html Msg
insertDay model year week day =
    div [ class "day" ]
        [ div []
            [ ul []
                [ li [] [ text "Nørd" ]
                , li [] [ text "Piano" ]
                , li [] [ text "Koreansk" ]
                , li [] [ button [] [ text "+" ] ]
                ]
            ]
        ]
