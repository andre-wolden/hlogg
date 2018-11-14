module Models.Types exposing (Activities, Activity, AddRecordBlockState(..), Date, Dates, Now, Page(..), Record, Records, ViewStateAddRecordOnDate(..))


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
    , dayOfMonth : Int
    }


type ViewStateAddRecordOnDate
    = Initial


type alias Dates =
    List Date


type alias Date =
    { localDate : String
    , year : Int
    , month : String
    , week : Int
    , dayOfWeek : String
    }


type Page
    = Years
    | Year Int
    | Week Int Int
    | Debug



-- END
