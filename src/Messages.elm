module Messages exposing (Metadata, Msg(..))

import Http
import Json.Decode as Decode
import Model


type alias Metadata =
    { author : String
    , pages : Int
    }


type Msg
    = NoOp
    | LoadRecords (Result Http.Error Model.Records)
    | LoadActivities (Result Http.Error Model.Activities)
    | ExpandAddRecordList
    | CollapseAddRecordList
    | AddActivityWithIdOf Int
    | RecordAdded (Result Http.Error Model.Record)
    | DeleteRecord Int
