module Update exposing (update)

import Commands
import Debug
import Http
import Json.Decode as Decode
import Messages exposing (..)
import Models.Model exposing (Model)
import Models.Types exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Messages.NoOp ->
            ( model, Cmd.none )

        Messages.Alert ->
            ( { model | debugMessage = "ALERT" }, Cmd.none )

        -- http stuff
        Messages.LoadRecords (Ok records) ->
            ( { model | records = records }, Cmd.none )

        Messages.LoadRecords (Err error) ->
            ( { model | debugMessage = "loading all reacords failed with error: " ++ Debug.toString error }, Cmd.none )

        Messages.LoadActivities (Ok activities) ->
            ( { model | activities = activities }, Cmd.none )

        Messages.LoadActivities (Err error) ->
            ( { model | debugMessage = "loading all activities failed with error: " ++ Debug.toString error }, Cmd.none )

        -- Stuff on page
        Messages.ExpandAddRecordList ->
            ( { model | addRecordBlockState = ListOfActivities }, Cmd.none )

        Messages.CollapseAddRecordList ->
            ( { model | addRecordBlockState = PlusSign }, Cmd.none )

        Messages.AddActivityWithIdOf int ->
            ( { model
                | debugMessage = String.fromInt int
                , addRecordBlockState = PlusSign
              }
            , Commands.postNewRecord int
            )

        Messages.DeleteRecord recordId ->
            ( model, Commands.deleteRecord recordId )

        -- More http stuff
        Messages.RecordAdded (Ok record) ->
            ( { model | records = (::) record model.records }, Cmd.none )

        Messages.RecordAdded (Err error) ->
            ( { model | debugMessage = "posting new record failed with error message: " ++ Debug.toString error }, Cmd.none )

        Messages.RecordDeleted (Ok success) ->
            ( model, Commands.getRecords )

        Messages.RecordDeleted (Err error) ->
            ( { model | debugMessage = "Was not able to delete record. Error: " ++ Debug.toString error }, Cmd.none )

        Messages.GetNow (Ok now) ->
            ( { model | now = Just now }, Cmd.none )

        Messages.GetNow (Err error) ->
            ( { model | debugMessage = "Was not able to get time information. Error: " ++ Debug.toString error }, Cmd.none )

        -- Adding Record On date
        Messages.RecordOnDateChooseActivity activity_id ->
            let
                old_model =
                    model.subModelAddRecordOnDate

                new_model =
                    { old_model | activity_id = Just activity_id }
            in
            ( { model | subModelAddRecordOnDate = new_model, debugMessage = Debug.toString activity_id }, Cmd.none )

        Messages.NewRecordOnDateChooseDate string ->
            let
                old_model =
                    model.subModelAddRecordOnDate

                new_model =
                    { old_model | date = Just string }
            in
            ( { model | subModelAddRecordOnDate = new_model }, Cmd.none )

        Messages.SaveNewRecordOnDate activity_id date ->
            ( model, Commands.saveNewRecordOnDate activity_id date )

        -- Get all dates
        Messages.GetDates (Ok listOfDates) ->
            ( { model | dates = Just listOfDates }, Cmd.none )

        Messages.GetDates (Err error) ->
            ( { model | debugMessage = Debug.toString error }, Cmd.none )

        -- Mobile View stuff
        Messages.GoToYears ->
            ( { model | page = Years }, Cmd.none )

        Messages.GoToYear year ->
            ( { model | page = Year year }, Cmd.none )

        Messages.GoToWeek year week ->
            ( { model | page = Week year week }, Cmd.none )



-- END
