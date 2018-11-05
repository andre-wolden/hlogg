module Update exposing (update)

import Commands
import Debug
import Http
import Json.Decode as Decode
import Messages exposing (..)
import Model exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        Messages.NoOp ->
            ( model, Cmd.none )

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
            ( model, Cmd.none )

        Messages.RecordDeleted (Err error) ->
            ( { model | debugMessage = "Was not able to delete record. Error: " ++ Debug.toString error }, Cmd.none )



-- END
