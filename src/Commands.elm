module Commands exposing (baseUrl, decodeActivities, decodeActivity, decodeRecord, decodeRecords, deleteRecord, deleteRecordRequest, getActivities, getActivitiesRequest, getNow, getNowRequest, getRecords, getRecordsRequest, postNewRecord, postRecordBody, postRecordRequest)

import Http
import Json.Decode as Decode exposing (list, string)
import Json.Encode as Encode
import Messages exposing (..)
import Model exposing (Activities, Activity, Now, Record, Records)
import RemoteData exposing (WebData)


baseUrl : String
baseUrl =
    "http://localhost:8080"



-- Record Commands


getRecordsRequest : Http.Request Records
getRecordsRequest =
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


getRecords : Cmd Msg
getRecords =
    Http.send LoadRecords getRecordsRequest


postRecordBody : Int -> Http.Body
postRecordBody activity_id =
    Encode.object [ ( "activity_id", Encode.int activity_id ) ]
        |> Http.jsonBody


postRecordRequest : Int -> Http.Request Record
postRecordRequest activity_id =
    Http.post (baseUrl ++ "/records/new") (postRecordBody activity_id) decodeRecord


postNewRecord : Int -> Cmd Msg
postNewRecord activity_id =
    Http.send RecordAdded (postRecordRequest activity_id)


deleteRecordRequest : Int -> Http.Request Bool
deleteRecordRequest record_id =
    Http.request
        { method = "DELETE"
        , headers = []
        , url = baseUrl ++ "/records/delete/" ++ String.fromInt record_id
        , body = Http.emptyBody
        , expect = Http.expectJson Decode.bool
        , timeout = Nothing
        , withCredentials = False
        }


deleteRecord : Int -> Cmd Msg
deleteRecord record_id =
    Http.send RecordDeleted (deleteRecordRequest record_id)



-- Activity Commands


getActivitiesRequest : Http.Request Activities
getActivitiesRequest =
    Http.get (baseUrl ++ "/activities/all") decodeActivities


decodeActivities : Decode.Decoder Activities
decodeActivities =
    Decode.list decodeActivity


decodeActivity : Decode.Decoder Activity
decodeActivity =
    Decode.map2 Activity
        (Decode.field "ActivityId" Decode.int)
        (Decode.field "ActivityDescription" Decode.string)


getActivities : Cmd Msg
getActivities =
    Http.send LoadActivities getActivitiesRequest



-- Time Thingy


decodeNow : Decode.Decoder Now
decodeNow =
    Decode.map4 Now
        (Decode.field "Year" Decode.int)
        (Decode.field "Month" Decode.string)
        (Decode.field "Week" Decode.int)
        (Decode.field "Day" Decode.string)


getNowRequest : Http.Request Now
getNowRequest =
    Http.get (baseUrl ++ "/now") decodeNow


getNow : Cmd Msg
getNow =
    Http.send GetNow getNowRequest



--
-- {"activity_id": 1}
-- END
