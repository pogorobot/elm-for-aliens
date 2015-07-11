import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import StartApp
import Html exposing (..)

-- MODEL

type alias Model = Int

-- UPDATE

type Action = Tick | NoOp

update : Action -> Model -> Model
update action model =
  case action of 
    Tick -> model + 1
    NoOp -> model

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  collage 300 300
  [
    cos (toFloat model) + 50
      |> circle
      |> filled green
  ]
   |> fromElement

main = 
  StartApp.start { model = 0, update = update, view = view }