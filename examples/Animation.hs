-- | Display an animation.
--
import Graphics.Gloss

picture :: Float -> Picture                      -- an animation is a picture that depends on time
picture time = rectangleSolid 20 (10*time)       -- this rectangle grows 10 pixels taller every second

main =  animate
    ( InWindow
        "Animation"
        (500, 650)
        (20,  20) )
	white
    picture

