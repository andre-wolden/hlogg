module Model exposing (Activities, Activity, AddRecordBlockState(..), Model, Now, Record, Records)


type alias Model =
    { debugMessage : String
    , records : Records
    , activities : Activities
    , addRecordBlockState : AddRecordBlockState
    , now : Maybe Now
    }


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


type AddRecordBlockState
    = PlusSign
    | ListOfActivities


type alias Now =
    { year : Int
    , month : String
    , week : Int
    , day : String
    }



-- END
