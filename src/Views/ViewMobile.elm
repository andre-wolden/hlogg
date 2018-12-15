module Views.ViewMobile exposing (viewOnMobile)

import Html exposing (Html, br, button, div, i, img, li, p, text, ul)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models.Model exposing (Model)
import Models.Types exposing (Page(..))
import Views.Burger exposing (burger, burgerOpen)
import Views.BurgerMenu exposing (burgerMenu)
import Views.DropDownMenu exposing (dropDownMenu)


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

        Debug ->
            div [] [ text "again, something wrong going on" ]


insertYearsView : Model -> Html Msg
insertYearsView model =
    div [ class "years" ]
        [ div [ class "line" ] [ button [ class "year_button", onClick (GoToYear 2018) ] [ text "2018" ] ]
        , div [ class "line" ] [ button [ class "year_button", onClick (GoToYear 2017) ] [ text "2017" ] ]
        , div [ class "line" ] [ button [ class "year_button", onClick (GoToYear 2016) ] [ text "2016" ] ]
        , div [ class "line" ] [ button [ class "year_button", onClick (GoToYear 2015) ] [ text "2015" ] ]
        , div [ class "line" ] [ button [ class "year_button", onClick (GoToYear 2014) ] [ text "2014" ] ]
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
