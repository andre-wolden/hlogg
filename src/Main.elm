port module Main exposing (main, toJs)

import Browser
import Browser.Navigation as Nav
import Commands exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http exposing (Error(..))
import Json.Decode as Decode
import Messages exposing (Msg)
import Model exposing (AddRecordBlockState(..), Model)
import Update exposing (update)
import Url exposing (Url)
import Url.Parser as UrlParser
import View exposing (view)


port toJs : String -> Cmd msg


main : Program Int Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , view =
            \m ->
                { title = "Elm 0.19 starter"
                , body = [ view m ]
                }
        , subscriptions = \_ -> Sub.none
        }


init : Int -> ( Model, Cmd Msg )
init counter =
    ( { debugMessage = "init..."
      , records = []
      , activities = []
      , addRecordBlockState = Model.PlusSign
      }
    , Cmd.batch
        [ Commands.executeGetRecords
        , Commands.executeGetActivities
        ]
    )
