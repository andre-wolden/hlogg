module Commands exposing
    ( decodeRecords
    , deleteRecord
    , executeGetActivities
    , executeGetRecords
    , getRecords
    , postRecord
    , sendNewRecord
    )

import Http
import Json.Decode as Decode exposing (list, string)
import Json.Encode as Encode
import Messages exposing (..)
import Model exposing (Activities, Activity, Record, Records)
import RemoteData exposing (WebData)


baseUrl : String
baseUrl =
    "http://localhost:8080"


getRecords : Http.Request Records
getRecords =
    Http.get (baseUrl ++ "/records/all") decodeRecords


decodeRecords : Decode.Decoder Records
decodeRecords =
    Decode.list decodeRecord


decodeRecord : Decode.Decoder Record
decodeRecord =
    Decode.map4 Record
        (Decode.field "id" Decode.int)
        (Decode.field "date" Decode.string)
        (Decode.field "week" Decode.int)
        (Decode.field "activity"
            (Decode.map2 Activity
                (Decode.field "ActivityId" Decode.int)
                (Decode.field "ActivityDescription" Decode.string)
            )
        )


executeGetRecords : Cmd Msg
executeGetRecords =
    Http.send LoadRecords getRecords


getActivities : Http.Request Activities
getActivities =
    Http.get (baseUrl ++ "/activities/all") decodeActivities


decodeActivities : Decode.Decoder Activities
decodeActivities =
    Decode.list decodeActivity


decodeActivity : Decode.Decoder Activity
decodeActivity =
    Decode.map2 Activity
        (Decode.field "ActivityId" Decode.int)
        (Decode.field "ActivityDescription" Decode.string)


executeGetActivities : Cmd Msg
executeGetActivities =
    Http.send LoadActivities getActivities


postRecordBody : Int -> Http.Body
postRecordBody activity_id =
    Encode.object [ ( "activity_id", Encode.int activity_id ) ]
        |> Http.jsonBody


postRecord : Int -> Http.Request Record
postRecord activity_id =
    Http.post (baseUrl ++ "/records/new") (postRecordBody activity_id) decodeRecord


sendNewRecord : Int -> Cmd Msg
sendNewRecord activity_id =
    Http.send RecordAdded (postRecord activity_id)


deleteRecord : Int -> Cmd Msg
deleteRecord int =
    Cmd.none



--
-- {"activity_id": 1}
-- END
