module Models.SubModelAddRecordOnDate exposing (SubModelAddRecordOnDate)

import Models.Types exposing (AddRecordBlockState, ViewStateAddRecordOnDate)


type alias SubModelAddRecordOnDate =
    { viewState : ViewStateAddRecordOnDate
    , activity_id : Maybe Int
    , date : String
    }
