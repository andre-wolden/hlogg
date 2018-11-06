module Models.Types exposing (Activities, Activity, AddRecordBlockState(..), Now, Record, Records, ViewStateAddRecordOnDate(..))


type AddRecordBlockState
    = PlusSign
    | ListOfActivities


type alias Records =
    List Record


type alias Record =
    { id : Int
    , date : String
    , week : Int
    , activity : Activity
    }


type alias Activities =
    List Activity


type alias Activity =
    { activityId : Int
    , activityDescription : String
    }


type alias Now =
    { year : Int
    , month : String
    , week : Int
    , day : String
    }


type ViewStateAddRecordOnDate
    = Initial
