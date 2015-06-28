import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Html exposing (..)
import StartApp

main =
  StartApp.start
    { model = head
    , update = update
    , view = view
    }

--MODEL

type alias Model = Element

--UPDATE

type Action = NoOp | Tick

update : Action -> Model -> Model
update action model = 
  model

--VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div []
  [ head

  ]

head : Element
head =
  collage 300 300
    [ circle 75
        |> filled green
        |> move (-10,0)
    , circle 50
        |> filled green
        |> move (50,10)
    ]
  
skull : Form
skull =
  circle 75
    |> filled green
    |> move (-10,0)