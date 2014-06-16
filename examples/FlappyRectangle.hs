-- | A game of skill and geometry.
--
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

main = play
    (InWindow "Flappy Rectangle" (floor gameHeight, 500) (100, 100))
    white
    fps
    initialState
    displayGame
    controls
    update

    where
        fps = 50
        initialState = State 0 ((gameHeight/2)-50) 0 0 0

-- Game dimensions
gameHeight :: Height
gameHeight = 500


-- The state of the game is defined by
-- the position of the flappy rectangle
-- the angle of the flappy rectangle
-- the current score
data State = State Jump Height Distance Angle Score
type Jump = Float
type Height = Float
type Distance = Float
type Angle = Float
type Score = Integer


-- The displayGame function turns a game state into a picture
displayGame :: State -> Picture
displayGame (State _ y x angle score) = 
    Pictures [ Translate 0    y flappy
             , Translate (-x) 0 tunnels ]

-- The flappy function displayGames the flappy picture
flappy :: Picture
flappy = rectangleSolid 30 20

-- The tunnels function returns the tunnel pictures
tunnels :: Picture
tunnels = Pictures (zipWith placeTunnel heights [1..numHeights])
    where
          placeTunnel height n = horizontal (n*tunnelDist) (tunnel height)
          horizontal h = Translate h 0
          heights = [250, 110, 200, 120, 280, 320, 210, 260, 350, 120, 80, 150] 
          numHeights = fromIntegral (length heights)
          tunnelDist = 280

-- The tunnel function takes the height of a gap and returns the picture of the tunnel
tunnel :: Height -> Picture
tunnel height = Pictures [ Translate 0 (gameHeight/2)  topRect
                         , Translate 0 (-gameHeight/2) bottomRect ]
    where
          topRect = Translate 0 (-topRectHeight/2) (rectangleSolid tunnelWidth topRectHeight)
          topRectHeight = (gameHeight - bottomRectHeight - gap)
          bottomRect = Translate 0 (bottomRectHeight/2) (rectangleSolid tunnelWidth bottomRectHeight)
          bottomRectHeight = (height - halfGap)
          tunnelWidth = 30
          halfGap = gap/2
          gap = 200


-- The update function modifies the game over time
-- here the distance increases over time
-- the height of the flappy rectangle falls and jumps
-- and the state of jumping progresses
type Time = Float
update :: Time -> State -> State
update t (State jump height dist angle score) = State
    (max (jump - (t/jumpTime)) 0)
    (height - (fallingSpeed*t) + if jump > 0 then (jumpDistance/jumpTime)*t else 0)
    (dist + (speed*t))
    angle
    score

    where
        speed = 100
        jumpTime = 0.2
        jumpDistance = 100
        fallingSpeed = 250

-- The controlls function takes keyboard and mouse events and modifies the game
-- we're only looking at when the up key is pressed
controls :: Event -> State -> State
controls (EventKey (SpecialKey key) Down _ _) s = case key of
    KeyUp     -> State jumpState height dist angle score
    otherwise -> s

    where 
          (State jump height dist angle score) = s 
          jumpState = if jump > 0 then jump else 1

controls e s = s
