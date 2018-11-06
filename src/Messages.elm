module Messages exposing (Metadata, Msg(..))

import Http
import Json.Decode as Decode
import Models.Types exposing (Activities, Now, Record, Records)


type alias Metadata =
    { author : String
    , pages : Int
    }


type Msg
    = NoOp
    | LoadRecords (Result Http.Error Records)
    | LoadActivities (Result Http.Error Activities)
    | ExpandAddRecordList
    | CollapseAddRecordList
    | AddActivityWithIdOf Int
    | RecordAdded (Result Http.Error Record)
    | DeleteRecord Int
    | RecordDeleted (Result Http.Error Bool)
    | GetNow (Result Http.Error Now)
    | RecordOnDateChooseActivity Int
    | NewRecordOnDateChooseDate String
