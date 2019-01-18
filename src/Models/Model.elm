module Models.Model exposing (Model)

import Models.SubModelAddRecordOnDate exposing (SubModelAddRecordOnDate)
import Models.Types exposing (..)
import Spinner


type alias Model =
    { debugMessage : String
    , records : Records
    , activities : Activities
    , addRecordBlockState : AddRecordBlockState
    , now : Maybe Now
    , subModelAddRecordOnDate : SubModelAddRecordOnDate
    , dates : Maybe Dates
    , page : Page
    , burgerStatus : BurgerStatus
    , dateToOpenListOfActivitiesFor : Maybe Date
    }



-- END
