module Views.ViewWeek exposing (insertWeekView)

import Html exposing (Html, br, button, div, i, img, li, p, text, ul)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Models.Model exposing (Model)
import Models.Types exposing (Date, Page(..), Record, Records)


insertWeekView : Model -> Int -> Int -> Html Msg
insertWeekView model year week =
    div [ class "week" ]
        [ insertWeekHeader year week
        , insertWeekBody model year week
        ]


insertWeekHeader : Int -> Int -> Html Msg
insertWeekHeader year week =
    div [ class "weekHeader" ]
        [ button [ class "backArrow", onClick (GoToYear year) ] [ i [ class "fas fa-angle-left" ] [] ]
        , div [ class "weekTitle" ] [ text (Debug.toString year ++ ", Week " ++ Debug.toString week) ]
        ]


insertWeekBody : Model -> Int -> Int -> Html Msg
insertWeekBody model year week =
    div [ class "weekBody" ] (insertListOfDays model year week)


insertListOfDays : Model -> Int -> Int -> List (Html Msg)
insertListOfDays model year week =
    let
        listDates =
            getListOfDates model year week

        listWeekRecords =
            getListOfRecordsForCurrentWeek model.records year week
    in
    List.map (insertDaySection listWeekRecords) listDates


insertDaySection : List Record -> Date -> Html Msg
insertDaySection listOfRecords date =
    div [] <|
        List.append [ text date.dayOfWeek ] <|
            List.map (renderRecordRow date) listOfRecords


renderRecordRow : Date -> Record -> Html Msg
renderRecordRow date record =
    if record.date == date.localDate then
        div [ class "recordRow" ] [ text record.activity.activityDescription ]

    else
        div [] []


getListOfDates : Model -> Int -> Int -> List Date
getListOfDates model year week =
    case model.dates of
        Just dates ->
            List.filter
                (\date ->
                    if date.year == year && date.week == week then
                        True

                    else
                        False
                )
                dates

        Nothing ->
            []


getListOfRecordsForCurrentWeek : Records -> Int -> Int -> Records
getListOfRecordsForCurrentWeek records year week =
    List.filter (recordInYearAndWeek year week) records


recordInYearAndWeek : Int -> Int -> Record -> Basics.Bool
recordInYearAndWeek year week record =
    let
        yearOfRecord =
            maybeYearOfRecord record
    in
    case yearOfRecord of
        Just justYearOfRecord ->
            if justYearOfRecord == year && record.week == week then
                True

            else
                False

        Nothing ->
            False


maybeYearOfRecord : Record -> Maybe Int
maybeYearOfRecord record =
    record.date
        |> String.slice 0 4
        |> String.toInt



-- end
