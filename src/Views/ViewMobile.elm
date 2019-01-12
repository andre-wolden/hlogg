module Views.ViewMobile exposing (viewOnMobile)

import Html exposing (Html, br, button, div, i, img, li, p, text, ul)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models.Model exposing (Model)
import Models.Types exposing (Page(..))
import Views.About exposing (viewAbout)
import Views.Burger exposing (burger, burgerOpen)
import Views.BurgerMenu exposing (burgerMenu)
import Views.DropDownMenu exposing (dropDownMenu)
import Views.Graphs exposing (viewGraphs)
import Views.Statistics exposing (viewStatistics)
import Views.ViewWeek exposing (insertWeekView)
import Views.ViewYear exposing (insertYearView)
import Views.ViewYears exposing (insertYearsView)


viewOnMobile : Model -> Html Msg
viewOnMobile model =
    div []
        [ div [ class "top" ]
            [ div [ class "firstBlock" ] [ insertDateToday model ]
            , div [ class "secondBlock" ]
                [ div [ class "topWeek" ] [ insertCurrentWeek model ]
                , burgerMenu model.burgerStatus
                ]
            , dropDownMenu model
            ]
        , div [ class "body" ]
            [ body model ]
        , div [ class "footer" ] [ text "Hobby Logger" ]
        ]


body : Model -> Html Msg
body model =
    case model.page of
        Years ->
            insertYearsView model

        Year year ->
            insertYearView model year

        Week year week ->
            insertWeekView model year week

        Statistics ->
            viewStatistics model

        Graphs ->
            viewGraphs model

        About ->
            viewAbout model

        Debug ->
            div [] [ text "again, something wrong goin' on" ]


insertDateToday : Model -> Html Msg
insertDateToday model =
    case model.now of
        Just now ->
            text (Debug.toString now.year ++ "-" ++ now.month ++ "-" ++ Debug.toString now.dayOfMonth)

        Nothing ->
            text "loading"


insertCurrentWeek model =
    case model.now of
        Just now ->
            text ("Week " ++ Debug.toString now.week)

        Nothing ->
            text "loading"



-- END
