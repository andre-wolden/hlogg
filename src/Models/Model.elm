module Models.Model exposing (Model)

import Models.SubModelAddRecordOnDate exposing (SubModelAddRecordOnDate)
import Models.Types exposing (..)


type alias Model =
    { debugMessage : String
    , records : Records
    , activities : Activities
    , addRecordBlockState : AddRecordBlockState
    , now : Maybe Now
    , subModelAddRecordOnDate : SubModelAddRecordOnDate
    }



-- END
