import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)

main : Element
main =
  head

head : Element
head =
  collage 300 300
    [ skull
    , circle 50
        |> filled green
        |> move (50,10)
    ]
  
skull : Form
skull =
  circle 75
    |> filled green
    |> move (-10,0)