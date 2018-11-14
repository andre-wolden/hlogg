module View exposing (view)

import Html exposing (Html, button, div, input, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick, onInput)
import Messages exposing (Msg)
import Models.Model exposing (Model)
import Models.SubModelAddRecordOnDate exposing (..)
import Models.Types exposing (..)
import Views.ViewMobile exposing (viewOnMobile)


view : Model -> Html Msg
view model =
    case model.page of
        Years ->
            viewOnMobile model

        Year year ->
            viewOnMobile model

        Week year week ->
            viewOnMobile model

        Debug ->
            div [ class "container" ]
                [ div [ class "block" ] [ text "Hobby Logg" ]
                , div [ class "nowBlock" ] [ viewNow model.now ]
                , div [ class "block" ] (List.map viewRecord model.records)
                , div [ class "block" ] (List.map viewActivity model.activities)
                , div [ class "block" ]
                    [ text "Lagre Ny Record"
                    , addRecordBlock model.addRecordBlockState model.activities
                    ]
                , div [ class "block" ] [ text "Lagre Ny Aktivitet" ]
                , div [ class "block" ] [ addRecordOnDateBlock model.subModelAddRecordOnDate model.activities ]
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
        PlusSign ->
            div []
                [ button [ onClick Messages.ExpandAddRecordList ] [ text "+" ]
                ]

        ListOfActivities ->
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
                [ span [] [ text (Debug.toString now.year ++ "-" ++ now.month ++ "-" ++ Debug.toString now.dayOfMonth) ]
                , span [] [ text ("Week: " ++ Debug.toString now.week) ]
                , span [] [ text ("Day: " ++ now.day) ]
                ]



-- Add Record On DATE


addRecordOnDateBlock : SubModelAddRecordOnDate -> Activities -> Html Msg
addRecordOnDateBlock submodel activities =
    case submodel.viewState of
        Initial ->
            div []
                [ text "Add record on specific date block"
                , addRecordOnDateValidEntry submodel
                , listActivitiesToChooseAmong activities
                , input [ onInput Messages.NewRecordOnDateChooseDate ] []
                , div [] [ text (Debug.toString submodel.activity_id) ]
                , div [] [ text (Debug.toString submodel.date) ]
                ]


addRecordOnDateValidEntry : SubModelAddRecordOnDate -> Html Msg
addRecordOnDateValidEntry submodel =
    case ( submodel.activity_id, submodel.date ) of
        ( Just activity_id, Just date ) ->
            button [ class "validButtonEntry", onClick (Messages.SaveNewRecordOnDate activity_id date) ] [ text "Now you can save" ]

        ( Nothing, _ ) ->
            button [ class "invalidButtonEntry" ] [ text "SAVE" ]

        ( _, Nothing ) ->
            button [ class "invalidButtonEntry" ] [ text "SAVE" ]


listActivitiesToChooseAmong : Activities -> Html Msg
listActivitiesToChooseAmong activities =
    div [] (List.map recordOnDateChooseActivity activities)


recordOnDateChooseActivity : Activity -> Html Msg
recordOnDateChooseActivity activity =
    button [ onClick (Messages.RecordOnDateChooseActivity activity.activityId) ] [ text activity.activityDescription ]



-- END
