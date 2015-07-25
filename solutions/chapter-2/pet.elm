import Text exposing(fromString)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
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
    Stroke -> { model | happiness <- model.happiness + 10 - model.hunger }
    Feed food -> { model | hunger <- model.hunger - toFloat (String.length(food))}
    Play -> { model | love <- model.love + model.happiness - model.hunger }
    Wait -> { name = model.name, hunger = model.hunger + 0.1, happiness = model.happiness - 0.1, love = model.love - 0.01 }


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
  Signal.merge actionMailbox.signal timeSignal

--VIEW

view : Signal.Address Action -> Model -> Html
view address model =
    div [myStyle]
    [ messageFrom model
    , billMurray
    , petButton address
    , feedButton address
    , playButton address
    ]

petButton : Signal.Address Action -> Html
petButton address = button
  [ onClick address Stroke 
  ] [ text "Pet"]

feedButton : Signal.Address Action -> Html
feedButton address = button
  [ onClick address (Feed "Carrots") ] [text "Feed"]

playButton : Signal.Address Action -> Html
playButton address = button
  [ onClick address Play ] [text "Play"]

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