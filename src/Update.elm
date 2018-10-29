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

        Messages.LoadRecords (Ok records) ->
            ( { model | records = records }, Cmd.none )

        Messages.LoadRecords (Err error) ->
            ( model, Cmd.none )

        Messages.LoadActivities (Ok activities) ->
            ( { model | activities = activities }, Cmd.none )

        Messages.LoadActivities (Err error) ->
            ( { model | debugMessage = Debug.toString error }, Cmd.none )

        Messages.ExpandAddRecordList ->
            ( { model | addRecordBlockState = ListOfActivities }, Cmd.none )

        Messages.CollapseAddRecordList ->
            ( { model | addRecordBlockState = PlusSign }, Cmd.none )

        Messages.AddActivityWithIdOf int ->
            ( { model
                | debugMessage = String.fromInt int
                , addRecordBlockState = PlusSign
              }
            , Commands.sendNewRecord int
            )

        Messages.RecordAdded (Ok activities) ->
            ( model, Cmd.none )

        Messages.RecordAdded (Err error) ->
            ( model, Cmd.none )

        Messages.DeleteRecord recordId ->
            ( model, Commands.deleteRecord recordId )



-- END
