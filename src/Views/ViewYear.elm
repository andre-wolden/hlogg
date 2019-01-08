module Views.ViewYear exposing (insertYearView, yearTitle)

import Html exposing (Html, br, button, div, i, img, li, p, text, ul)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models.Model exposing (Model)
import Models.Types exposing (Date, Dates, Page(..))
import Set exposing (fromList)


insertYearView : Model -> Int -> Html Msg
insertYearView model year =
    div [ class "weeks" ]
        [ div [ class "yearHeader" ]
            [ button [ class "backArrow", onClick GoToYears ] [ i [ class "fas fa-angle-left" ] [] ]
            , yearTitle model.page
            ]
        , div [ class "yearBody" ] (List.map (insertWeekSquare model year) (listOfWeekNumbersInYear model.dates year))
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


listOfWeekNumbersInYear : Maybe Dates -> Int -> List Int
listOfWeekNumbersInYear maybeDates year =
    case maybeDates of
        Just dates ->
            List.filter (dateInYear year) dates
                |> List.map (\date -> date.week)
                |> Set.fromList
                |> Set.toList

        Nothing ->
            []


dateInYear : Int -> Date -> Basics.Bool
dateInYear year date =
    if (==) date.year year then
        True

    else
        False



-- END
