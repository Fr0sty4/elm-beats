module DialKit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Svg
import Svg.Attributes as SvgA

renderPlayButton : Bool -> a -> a -> Html a
renderPlayButton isPlaying msgOnPlayClicked msgOnStopClicked =
  button [id "play-button", class "transport-button-svg"]
  [ Svg.svg []
    [ buttonOutline
    , if isPlaying then
        drawStopButton msgOnStopClicked
      else
        drawPlayButton msgOnPlayClicked
    ]
  ]

buttonOutline : Html a
buttonOutline =
  Svg.rect [ SvgA.class "transport-button-outline" ] []

drawPlayButton : a -> Html a
drawPlayButton msgOnClick =
  Svg.polygon [ SvgA.class "transport-button button-decal", SvgA.points "20,20 100,60 20,100" ] []

drawStopButton : a -> Html a
drawStopButton msgOnClick =
  Svg.rect [ SvgA.class "transport-button button-decal", SvgA.x "20", SvgA.y "24", SvgA.width "60", SvgA.height "60" ] []

renderClearButton : a -> Html a
renderClearButton msgOnClick =
  Svg.svg [ SvgA.id "clear-button", SvgA.class "transport-button-svg" ]
  [ buttonOutline ]
