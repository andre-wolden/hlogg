module View exposing (view)

import Html exposing (Html, button, div, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Messages exposing (Msg)
import Model exposing (Activities, Activity, AddRecordBlockState(..), Model, Now, Record)


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "block" ] [ text "TITTEL" ]
        , div [ class "nowBlock" ] [ viewNow model.now ]
        , div [ class "block" ] (List.map viewRecord model.records)
        , div [ class "block" ] (List.map viewActivity model.activities)
        , div [ class "block" ]
            [ div []
                [ text "Lagre Ny Record"
                , addRecordBlock model.addRecordBlockState model.activities
                ]
            ]
        , div [ class "block" ]
            [ div [] [ text "Lagre Ny Aktivitet" ] ]
        , div [ class "block" ] [ text model.debugMessage ]
        ]


viewRecord : Record -> Html Msg
viewRecord record =
    div [ class "record" ]
        [ text "ID: "
        , text (Debug.toString record.id)
        , text " -- "
        , text "DATO: "
        , text record.date
        , text " -- "
        , text "Week: "
        , text (Debug.toString record.week)
        , text " -- "
        , text "Activity: "
        , text record.activity.activityDescription
        , text " -- "
        , button [ onClick (Messages.DeleteRecord record.id) ] [ text "x" ]
        ]


viewActivity : Activity -> Html Msg
viewActivity activity =
    div []
        [ text ("Activity: " ++ activity.activityDescription)
        ]


addRecordBlock : AddRecordBlockState -> Activities -> Html Msg
addRecordBlock addRecordBlockState activities =
    case addRecordBlockState of
        Model.PlusSign ->
            div []
                [ button [ onClick Messages.ExpandAddRecordList ] [ text "+" ]
                ]

        Model.ListOfActivities ->
            div []
                [ div [] (List.map addRecordBlockActivityElement activities)
                , button [ onClick Messages.CollapseAddRecordList ] [ text "x" ]
                ]


addRecordBlockActivityElement : Activity -> Html Msg
addRecordBlockActivityElement activity =
    button [ onClick (Messages.AddActivityWithIdOf activity.activityId) ] [ text activity.activityDescription ]


viewNow : Maybe Now -> Html Msg
viewNow maybeNow =
    case maybeNow of
        Nothing ->
            div [ class "block" ] [ text "NOTHING !" ]

        Just now ->
            div [ class "now" ]
                [ span [] [ text ("Year: " ++ Debug.toString now.year) ]
                , span [] [ text ("Month: " ++ now.month) ]
                , span [] [ text ("Week: " ++ Debug.toString now.week) ]
                , span [] [ text ("Day: " ++ now.day) ]
                ]



-- END
