import Text exposing(fromString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Graphics.Element exposing (..)
import Signal exposing (..)
import String exposing(padRight)
import Mouse exposing (..)
import Time exposing (..)

--MODEL
type alias Model = 
  { name : String
  , hunger : Float
  , happiness : Float
  , love : Float
  }

init : Model
init =
  { name = "Bill Murray"
  , hunger = 0
  , happiness = 100
  , love = 1
  }


--UPDATE
type Action = Stroke
  | Feed String
  | Play
  | Wait
  | NoOp

update : Action -> Model -> Model
update action model =
  case action of
    Stroke -> { model | happiness <- model.happiness * 1.2}
    Feed food -> { model | hunger <- model.hunger - toFloat (String.length(food))}
    Play -> { model | love <- model.love * model.happiness }
    Wait -> { name = model.name, hunger = model.hunger + 0.01, happiness = model.happiness - 0.01, love = model.love - 0.001 }


timeSignal : Signal Action
timeSignal =
  Signal.map clock (fps 30)

clock : Time -> Action
clock time =
  Wait

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
  timeSignal

--VIEW

view : Signal.Address Action -> Model -> Html
view address model =
    div [myStyle]
    [ messageFrom model
    , billMurray
    ]

messageFrom : Model -> Html
messageFrom model =
  model.name ++ " is " ++ toString (floor model.happiness) ++ " happy and " ++ toString (floor model.hunger) ++ " hungry. She loves you " ++ toString (floor model.love) ++ " much!"
  |> Html.text

myStyle : Attribute
myStyle =
  style
    [ ("width", "100%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]

billMurray : Html
billMurray =
  image 300 300 "bill-murray.jpg"
  |> fromElement

main =
  Signal.map (view address)
    (Signal.foldp update init actions) 