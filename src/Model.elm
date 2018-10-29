module Model exposing
    ( Activities
    , Activity
    , AddRecordBlockState(..)
    , Model
    , Record
    , Records
    )


type alias Model =
    { debugMessage : String
    , records : Records
    , activities : Activities
    , addRecordBlockState : AddRecordBlockState
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
