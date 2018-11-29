module Views.BurgerMenu exposing (burgerMenu)

import Html exposing (..)
import Messages exposing (Msg(..))
import Models.Types exposing (..)
import Views.Burger exposing (burger, burgerOpen)


burgerMenu : BurgerStatus -> Html Msg
burgerMenu burgerStatus =
    case burgerStatus of
        Closed ->
            burger

        Open ->
            burgerOpen
