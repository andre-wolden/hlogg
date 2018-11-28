module Views.Burger exposing (burger)

import Debug exposing (toString)
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Messages exposing (Msg(..))
import Svg exposing (circle, rect, svg)
import Svg.Attributes exposing (color, cx, cy, fill, height, r, rx, ry, viewBox, width, x, y)



-- NEXT: Lag burger open. Legg til onClick, set state, og transitionburger. Trenger kanskje ikke animation.


burgerOpen : Html Msg
burgerOpen =
    button [ class "burgerOpen" ] []


burger : Html Msg
burger =
    button [ class "burger" ]
        [ svg
            [ width rectWidth
            , height (toString (rectHeight * 3 + spacing * 2))
            , viewBox ("0 0 " ++ rectWidth ++ " " ++ toString (rectHeight * 3 + spacing * 2))
            , Svg.Attributes.class "burgerSvg"
            ]
            [ rect
                [ x "0"
                , y "0"
                , width rectWidth
                , height (toString rectHeight)
                , rx cornerRadius
                , ry cornerRadius
                , fill rectColor
                ]
                []
            , rect
                [ x "0"
                , y (toString (rectHeight + spacing))
                , width rectWidth
                , height (toString rectHeight)
                , rx cornerRadius
                , ry cornerRadius
                , fill rectColor
                ]
                []
            , rect
                [ x "0"
                , y (toString ((rectHeight + spacing) * 2))
                , width rectWidth
                , height (toString rectHeight)
                , rx cornerRadius
                , ry cornerRadius
                , fill rectColor
                ]
                []
            ]
        ]


rectColor : String
rectColor =
    "white"


spacing : Float
spacing =
    rectHeight * 0.8


rectWidth : String
rectWidth =
    "45"


rectHeight : Float
rectHeight =
    8


cornerRadius : String
cornerRadius =
    "0"
