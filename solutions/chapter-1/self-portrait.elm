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
    , leftEye
    , rightEye
    , leftPupil
    , rightPupil
    , mouth
    ]
  
skull : Form
skull =
  circle 75
    |> filled skull_color
    |> move (-10,0)

leftEye : Form
leftEye =
  circle 10
    |> filled eyeColor
    |> move (50, 10)

leftPupil : Form
leftPupil =
  circle 5
    |> filled black
    |> move (50, 10)

rightEye : Form
rightEye =
  circle 10
    |> filled eyeColor
    |> move (10, 10)

rightPupil : Form
rightPupil =
  circle 5
    |> filled black
    |> move (10, 10)

mouth : Form
mouth =
  mouthPath
    |> traced { mouthStyle | width <- 2}

mouthPath : Path
mouthPath =
  path [(10, -20), (30, -30), (50, -20)]

mouthStyle : LineStyle
mouthStyle =
  solid mouthColor

mouthColor : Color
mouthColor =
  rgb 150 50 50

skull_color : Color
skull_color =
  rgb 75 130 0

eyeColor : Color
eyeColor =
  rgb 0 168 107