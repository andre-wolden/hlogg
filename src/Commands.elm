module Commands exposing (baseUrl, decodeActivities, decodeActivity, decodeRecord, decodeRecords, deleteRecord, deleteRecordRequest, getActivities, getActivitiesRequest, getDates, getNow, getNowRequest, getRecords, getRecordsRequest, postNewRecord, postRecordBody, postRecordRequest, saveNewRecordOnDate)

import Http
import Json.Decode as Decode exposing (list, string)
import Json.Encode as Encode
import Messages exposing (..)
import Models.Model exposing (Model)
import Models.SubModelAddRecordOnDate exposing (..)
import Models.Types exposing (..)
import RemoteData exposing (WebData)


baseUrl : String
baseUrl =
    -- "http://localhost:8383"
    "https://hlogg-be.herokuapp.com"



-- Record On Date Commands


saveNewRecordOnDate : Int -> String -> Cmd Msg
saveNewRecordOnDate activity_id date =
    Http.send RecordAdded (postNewRecordOnDateRequest activity_id date)


postNewRecordOnDateRequest : Int -> String -> Http.Request Record
postNewRecordOnDateRequest activity_id date =
    Http.post (baseUrl ++ "/records/new_with_date") (postNewRecordOnDateBody activity_id date) decodeRecord


postNewRecordOnDateBody : Int -> String -> Http.Body
postNewRecordOnDateBody activity_id date =
    Encode.object
        [ ( "activity_id", Encode.int activity_id )
        , ( "date", Encode.string date )
        ]
        |> Http.jsonBody



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


postNewRecordOnDate : Int -> String -> Cmd Msg
postNewRecordOnDate activity_id date =
    Http.send RecordAdded (postRecordOnDateRequest activity_id date)


postRecordOnDateRequest : Int -> String -> Http.Request Record
postRecordOnDateRequest activity_id date =
    Http.post (baseUrl ++ "/records/new_with_date") (postRecordBodyWithDate activity_id date) decodeRecord


postRecordBodyWithDate : Int -> String -> Http.Body
postRecordBodyWithDate activity_id date =
    Encode.object
        [ ( "activity_id", Encode.int activity_id )
        , ( "date", Encode.string date )
        ]
        |> Http.jsonBody



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


getNow : Cmd Msg
getNow =
    Http.send GetNow getNowRequest


getNowRequest : Http.Request Now
getNowRequest =
    Http.get (baseUrl ++ "/now") decodeNow


decodeNow : Decode.Decoder Now
decodeNow =
    Decode.map5 Now
        (Decode.field "year" Decode.int)
        (Decode.field "month" Decode.string)
        (Decode.field "week" Decode.int)
        (Decode.field "day" Decode.string)
        (Decode.field "dayOfMonth" Decode.int)



-- Dates


getDates : Cmd Msg
getDates =
    Http.send GetDates getDatesRequest


getDatesRequest : Http.Request Dates
getDatesRequest =
    Http.get (baseUrl ++ "/dates") decodeDates


decodeDates : Decode.Decoder Dates
decodeDates =
    Decode.list
        (Decode.map5 Date
            (Decode.field "localDate" Decode.string)
            (Decode.field "year" Decode.int)
            (Decode.field "month" Decode.string)
            (Decode.field "week" Decode.int)
            (Decode.field "dayOfWeek" Decode.string)
        )



--
-- {"activity_id": 1}
-- END
