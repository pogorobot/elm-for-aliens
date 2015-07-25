import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Html exposing (..)
import Time exposing (..)
import Signal exposing (..)

-- MODEL

type alias Model = Int

init : Model
init = 0

-- UPDATE

type Action = Tick 
  | Tock
  | NoOp


update : Action -> Model -> Model
update action model =
  case action of 
    Tick -> model + 4
    Tock -> model - 1
    NoOp -> model

clock : Signal Time
clock =
  Time.fps 30

cluck : Signal Time
cluck =
  Time.fps 60

-- This is the mailbox that receives all the actions
-- that will update the application.
actionMailbox : Mailbox Action
actionMailbox =
  Signal.mailbox NoOp

address : Address Action
address =
  actionMailbox.address

actions : Signal Action
actions =
  Signal.merge 
    (Signal.map ticker clock)
    (Signal.map clicker cluck)


ticker : Time -> Action
ticker time =
  if floor time % 2 == 0 then Tick else Tock

clicker : Time -> Action
clicker time =
  Tock

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  collage 300 300
  [
    cos (degrees (toFloat model)) * 50
      |> circle
      |> filled (rgb 75 130 0)
  ]
   |> fromElement

main =
  Signal.map (view address)
    (Signal.foldp update init actions) 
