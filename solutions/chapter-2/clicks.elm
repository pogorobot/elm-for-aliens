import Text exposing(fromString)
import Html exposing (..)
import Signal exposing (..)
import String exposing(padRight)
-- MODEL
type alias Model = Int

init : Model
init = 0

--UPDATE
type Action = Click
  | NoOp

update : Action -> Model -> Model
update action model =
  case action of
    Click -> model + 1
    NoOp -> model


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
   actionMailbox.signal

--VIEW

view : Signal.Address Action -> Model -> Html
view address model =
    div []
    [ Html.text (padRight model 'O' "YO")
    ]

main =
  Signal.map (view address)
    (Signal.foldp update init actions) 