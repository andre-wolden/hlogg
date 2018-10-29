module View exposing (view)

import Html exposing (Html, button, div, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Messages exposing (Msg)
import Model exposing (Activities, Activity, AddRecordBlockState(..), Model, Record)


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "block" ] [ text "TITTEL" ]
        , div [ class "block" ] [ text model.debugMessage ]
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
        ]


viewRecord : Record -> Html Msg
viewRecord record =
    div []
        [ text "DATO: "
        , text record.date
        , text " -- "
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



-- END
