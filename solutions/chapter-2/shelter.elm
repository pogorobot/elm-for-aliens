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
type alias Model = { name : String, leaving : Bool }

init : Model
init = { name = "", leaving = False }

--UPDATE
type Action = Name
  | Input String
  | NoOp

update : Action -> Model -> Model
update action model =
  case action of
    Name -> { model | leaving <- True }
    NoOp -> model
    Input string -> { model | name <- string }


actionMailbox : Mailbox Action
actionMailbox =
  Signal.mailbox NoOp

address : Address Action
address =
  actionMailbox.address

actions : Signal Action
actions =
  actionMailbox.signal


--VIEW


view : Signal.Address Action -> Model -> Html
view address model =
    div [myStyle]
    [ messageFrom model
    , shelterPic
    , nameInput model.name
    , nameButton address
    ]


messageFrom : Model -> Html
messageFrom model = 
  "It's finally time! You're at the shelter to adopt a beautiful, beloved pet. What will be her name?"
    |> Html.text

nameInput : String -> Html
nameInput string =
  input
    [ placeholder "Bill Murray"
    , value string
    , on "input" targetValue (Signal.message address << Input)
    , myStyle
    ]
    []

nameButton : Signal.Address Action -> Html
nameButton address =
  button
  [ onClick address Name ] [text "This!"]

myStyle : Attribute
myStyle =
  style
    [ ("width", "100%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]

shelterPic : Html
shelterPic =
  image 300 300 "shelter.jpg"
  |> fromElement

main =
  Signal.map (view address)
    (Signal.foldp update init actions)