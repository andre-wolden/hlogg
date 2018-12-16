module Views.ViewYear exposing (insertYearView, yearTitle)

import Html exposing (Html, br, button, div, i, img, li, p, text, ul)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models.Model exposing (Model)
import Models.Types exposing (Page(..))


insertYearView : Model -> Int -> Html Msg
insertYearView model year =
    div [ class "weeks" ]
        [ div [ class "yearHeader" ]
            [ button [ class "backArrow", onClick GoToYears ] [ i [ class "fas fa-angle-left" ] [] ]
            , yearTitle model.page
            ]
        , div [ class "yearBody" ] (List.map (insertWeekSquare model year) (List.range 1 52))
        ]


yearTitle : Page -> Html Msg
yearTitle page =
    case page of
        Year year ->
            div [ class "bodyTitle" ] [ text (Debug.toString year) ]

        _ ->
            div [] [ text "something wrong is going on..." ]


insertWeekSquare : Model -> Int -> Int -> Html Msg
insertWeekSquare model year week =
    div [ class "weekSquare" ] [ button [ onClick (GoToWeek year week) ] [ text (Debug.toString week) ] ]
