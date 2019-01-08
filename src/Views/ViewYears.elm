module Views.ViewYears exposing (insertYearsView)

import Html exposing (Html, br, button, div, i, img, li, p, text, ul)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (onClick)
import List exposing (head, map)
import Messages exposing (Msg(..))
import Models.Model exposing (Model)
import Models.Types exposing (Date, Dates, Page(..))
import Set exposing (fromList)


insertYearsView : Model -> Html Msg
insertYearsView model =
    div [ class "years" ] (insertListOfYears model.dates)


insertListOfYears : Maybe Dates -> List (Html Msg)
insertListOfYears maybeDates =
    case maybeDates of
        Just dates ->
            getListOfUniqueYears dates
                |> List.map renderYearRow

        Nothing ->
            []


getListOfUniqueYears : Dates -> List Int
getListOfUniqueYears dates =
    List.map (\d -> d.year) dates
        |> Set.fromList
        |> Set.toList


renderYearRow : Int -> Html Msg
renderYearRow year =
    div [ class "line" ] [ button [ class "year_button", onClick (GoToYear year) ] [ text (Debug.toString year) ] ]
