-- | Display a complex polygon in the form of a star.
--
import Graphics.Gloss

type Angle = Float

-- The rotatePoint function rotates one point around another point
-- the first point is the point to rotate around
-- the second input is the angle to rotate
-- the third input is the point which is being rotated
rotatePoint :: Point -> Angle -> Point -> Point
rotatePoint (x', y') a (x, y) = 
    (x''*c - y''*s, x''*s + y''*c)
    where
        x'' = x - x'
        y'' = y - y'
        angle = a * pi/180
        s = sin(angle)
        c = cos(angle)

-- The rotatePath function uses the rotatePoint function to rotate a list of points
rotatePath :: Point -> Angle -> Path -> Path 
rotatePath o a ps = map (rotatePoint o a) ps


-- A path that defines the point of a start
starPointPath :: Path
starPointPath = [(-10, 40), (0, 60), (10, 40)]

-- A path that defines a star with a number of points
starPath :: Integer -> Path
starPath points = concat $ zipWith rotateOrigin [0,angle..360] (repeat starPointPath) 
    where
        rotateOrigin = rotatePath (0, 0)
        angle = (360/(fromIntegral points))

-- A star with some number of points
star :: Integer -> Picture
star points = polygon $ starPath points

picture = star 20

main = display 
        (InWindow
           "Star"    -- window title
        (400, 150)   -- window size
        (10, 10))    -- window position
    white            -- background color
    picture          -- picture to display

