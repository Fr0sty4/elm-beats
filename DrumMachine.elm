port module DrumMachine exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import DialKit exposing (..)

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

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
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
  , renderControlButtons model.isPlaying
  , renderBeats model.musicGrid model.currentStep
  , renderFooter
  ]

renderHeading : Html Msg
renderHeading =
  div [id "heading-area"]
  [ h1 [id "heading"] [text "World Wide Beats"]
  , h4 [] [text "A Web Audio Beat-Machine Written In Elm"]
  ]

renderControlButtons : Bool -> Html Msg
renderControlButtons isPlaying =
  div [id "transport-control-buttons"]
  [ renderClearButton (Clear)
  , renderPlayButton isPlaying (Play) (Stop)
  ]

renderBeats : MusicGrid -> Int -> Html Msg
renderBeats music currentStep =
  div [id "music-grid"] []

renderFooter : Html Msg
renderFooter =
  div [id "footer"] []
