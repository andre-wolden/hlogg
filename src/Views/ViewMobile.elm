module Views.ViewMobile exposing (viewOnMobile)

import Html exposing (Html, br, button, div, i, img, p, text)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models.Model exposing (Model)
import Models.Types exposing (Page(..))


viewOnMobile : Model -> Html Msg
viewOnMobile model =
    div []
        [ div [ class "top" ]
            [ text "2018-11-01"
            , br [] []
            , div [ class "topWeek" ] [ text "Week 45" ]
            ]
        , div [ class "body" ]
            [ subPages model ]
        , div [ class "footer" ] [ text "Hobby Logger" ]
        ]


subPages : Model -> Html Msg
subPages model =
    case model.page of
        Years ->
            insertYearsView model

        Year year ->
            insertYearView model year

        Week year week ->
            insertWeekView model year week

        Debug ->
            div [] [ text "again, something wrong going on" ]


insertYearsView : Model -> Html Msg
insertYearsView model =
    div [ class "years" ]
        [ div [ class "line" ] [ button [ onClick (GoToYear 2018) ] [ text "2018" ] ]
        , div [ class "line" ] [ button [ onClick (GoToYear 2017) ] [ text "2017" ] ]
        , div [ class "line" ] [ button [ onClick (GoToYear 2016) ] [ text "2016" ] ]
        , div [ class "line" ] [ button [ onClick (GoToYear 2015) ] [ text "2015" ] ]
        , div [ class "line" ] [ button [ onClick (GoToYear 2014) ] [ text "2014" ] ]
        ]


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


insertWeekView : Model -> Int -> Int -> Html Msg
insertWeekView model year week =
    div [ class "week" ]
        [ div [ class "weekHeader" ]
            [ button [ class "backArrow", onClick (GoToYear year) ] [ i [ class "fas fa-angle-left" ] [] ]
            , div [ class "weekTitle" ] [ text ("Week " ++ Debug.toString week) ]
            ]
        , div [ class "weekBody" ]
            [ p [] [ text "Monday" ]
            , p [] [ text "Tuesday" ]
            , p [] [ text "Wednesday" ]
            , p [] [ text "Thursday" ]
            , p [] [ text "Friday" ]
            , p [] [ text "Saturday" ]
            , p [] [ text "Sunday" ]
            ]
        ]
