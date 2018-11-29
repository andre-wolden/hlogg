module Views.Burger exposing (burger, burgerOpen)

import Debug exposing (toString)
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Messages exposing (Msg(..))
import Svg exposing (circle, defs, rect, svg)
import Svg.Attributes as SvgAttr
    exposing
        ( color
        , cx
        , cy
        , fill
        , height
        , r
        , rotate
        , rx
        , ry
        , viewBox
        , width
        , x
        , y
        )



-- NEXT: Lag burger open. Legg til onClick, set state, og transitionburger. Trenger kanskje ikke animation.


burgerOpen : Html Msg
burgerOpen =
    button [ class "burger", onClick CloseBurger ]
        [ svg
            [ width (toString rectWidth)
            , height (toString (rectHeight * 3 + spacing * 2))
            , viewBox ("0 0 " ++ toString rectWidth ++ " " ++ toString (rectHeight * 3 + spacing * 2))
            , SvgAttr.class "burgerSvg"
            ]
            [ rect
                [ x "0"
                , y "0"
                , width (toString rectWidth)
                , height (toString rectHeight)
                , rx cornerRadius
                , ry cornerRadius
                , fill rectColor
                , rotate "45 60 60"

                -- , SvgAttr.transform ("rotate(45 " ++ toString rectWidth ++ " " ++ toString (rectHeight / 2))
                , SvgAttr.transform "rotate(45 22 4) translate(9 9)"
                ]
                []
            , rect
                [ x "0"
                , y (toString (rectHeight + spacing))
                , width (toString rectWidth)
                , height (toString rectHeight)
                , rx cornerRadius
                , ry cornerRadius
                , fill rectColor
                , SvgAttr.transform "rotate(-45 22 4) translate(-10 -5)"
                ]
                []
            ]
        ]


burger : Html Msg
burger =
    button [ class "burger", onClick OpenBurger ]
        [ svg
            [ width (toString rectWidth)
            , height (toString (rectHeight * 3 + spacing * 2))
            , viewBox ("0 0 " ++ toString rectWidth ++ " " ++ toString (rectHeight * 3 + spacing * 2))
            , SvgAttr.class "burgerSvg"
            ]
            [ rect
                [ x "0"
                , y "0"
                , width (toString rectWidth)
                , height (toString rectHeight)
                , rx cornerRadius
                , ry cornerRadius
                , fill rectColor
                ]
                []
            , rect
                [ x "0"
                , y (toString (rectHeight + spacing))
                , width (toString rectWidth)
                , height (toString rectHeight)
                , rx cornerRadius
                , ry cornerRadius
                , fill rectColor
                ]
                []
            , rect
                [ x "0"
                , y (toString ((rectHeight + spacing) * 2))
                , width (toString rectWidth)
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


rectWidth : Float
rectWidth =
    45


rectHeight : Float
rectHeight =
    8


cornerRadius : String
cornerRadius =
    "0"
