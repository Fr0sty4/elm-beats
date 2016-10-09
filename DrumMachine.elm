port module DrumMachine exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Svg
import Svg.Attributes as SvgA

import Array exposing (..)
main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type Intensity = Hard | Medium | Soft

type alias MusicGrid = Array (Array (Maybe Intensity))

type alias Model =
  { musicGrid : MusicGrid
  , tempo : Int
  , currentStep : Int
  , isPlaying : Bool
  , playStopButtonHighlighted : Bool
  , clearButtonHighlighted : Bool
  }

init : (Model, Cmd Msg)
init = (
  { musicGrid = Array.repeat 8 (Array.repeat 8 Nothing)
  , tempo = 80
  , currentStep = 0
  , isPlaying = False
  , playStopButtonHighlighted = False
  , clearButtonHighlighted = False
  }
  , Cmd.none)

-- UPDATE
type Msg = Tick
         | Play
         | Stop
         | Clear
         | AddNote Int Int
         | HighlightPlayStopButton Bool
         | HighlightClearButton Bool

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    HighlightPlayStopButton highlighted ->
      ({model | playStopButtonHighlighted = highlighted}, Cmd.none)
    HighlightClearButton highlighted ->
      ({model | clearButtonHighlighted = highlighted}, Cmd.none)
    Play ->
      ({model | isPlaying = True}, Cmd.none)
    Stop ->
      ({model | isPlaying = False}, Cmd.none)
    Clear ->
      ({model | musicGrid = Array.repeat 8 (Array.repeat 8 Nothing)}, Cmd.none)
    _ ->
      (model, Cmd.none)

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- VIEW
view : Model -> Html Msg
view model =
  div [id "main-app"]
  [ renderHeading
  , renderControlButtons model.isPlaying model.playStopButtonHighlighted model.clearButtonHighlighted
  , renderBeats model.musicGrid model.currentStep
  , renderFooter
  ]

renderHeading : Html Msg
renderHeading =
  div [id "heading-area"]
  [ h1 [id "heading"] [text "World Wide Beats"]
  , h4 [] [text "A Web Audio Beat-Machine Written In Elm"]
  ]

renderControlButtons : Bool -> Bool -> Bool -> Html Msg
renderControlButtons isPlaying playStopButtonHighlighted clearButtonHighlighted =
  div [id "transport-control-buttons"]
  [ renderClearButton clearButtonHighlighted
  , renderPlayButton isPlaying playStopButtonHighlighted
  ]

buttonOutline : Bool -> Html Msg
buttonOutline isHighlighted =
  Svg.rect [ SvgA.x "0", SvgA.y "4", SvgA.width "100", SvgA.height "100", SvgA.rx "15", SvgA.ry "15", SvgA.stroke "white", SvgA.strokeWidth "4px"
  , SvgA.fill (if isHighlighted then "white" else "None")] []

renderClearButton : Bool -> Html Msg
renderClearButton isHighlighted =
  Svg.svg [ SvgA.width "120", SvgA.height "120", SvgA.viewBox "0 0 120 120", onMouseDown (HighlightClearButton True), onMouseUp (HighlightClearButton False), onMouseLeave (HighlightClearButton False) ]
  [ buttonOutline isHighlighted ]

renderPlayButton : Bool -> Bool -> Html Msg
renderPlayButton isPlaying isHighlighted =
  Svg.svg [ SvgA.width "120", SvgA.height "120", SvgA.viewBox "0 0 120 120", onMouseDown (HighlightPlayStopButton True), onMouseUp (HighlightPlayStopButton False), onMouseLeave (HighlightPlayStopButton False) ]
  [ buttonOutline isHighlighted
  , if isPlaying then
      drawStopButton isHighlighted
    else
      drawPlayButton isHighlighted
  ]

drawPlayButton : Bool -> Html Msg
drawPlayButton isHighlighted =
  if isHighlighted then
    Svg.polygon [ SvgA.points "20,24 80,54 20,84", SvgA.fill "#996855", SvgA.stroke "white", SvgA.strokeWidth "4" ] []
  else
    Svg.polygon [ SvgA.points "20,24 80,54 20,84", SvgA.fill "None", SvgA.stroke "white", SvgA.strokeWidth "4" ] []

drawStopButton : Bool -> Html Msg
drawStopButton isHighlighted =
  if isHighlighted then
    Svg.rect [ SvgA.x "20", SvgA.y "24", SvgA.width "60", SvgA.height "60", SvgA.fill "#996855", SvgA.stroke "white", SvgA.strokeWidth "4" ] []
  else
    Svg.rect [ SvgA.x "20", SvgA.y "24", SvgA.width "60", SvgA.height "60", SvgA.fill "None", SvgA.stroke "white", SvgA.strokeWidth "4" ] []

renderBeats : MusicGrid -> Int -> Html Msg
renderBeats music currentStep =
  div [id "music-grid"] []

renderFooter : Html Msg
renderFooter =
  div [id "footer"] []
