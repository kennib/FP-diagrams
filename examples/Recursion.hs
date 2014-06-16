-- | Display an animation of recursion.
--
import Graphics.Gloss

circles :: Integer -> Picture                    -- this function creates a number of circles
circles 0 = Blank                                -- with 0 circles the picture is blank
circles n = Pictures [ aCircle                   -- with n circles the picture is a circle
                     , Translate (r*2) 0 smallerCircles ] -- plus to the right of that circle
                                                          -- we place all of the smaller circles
    where m = fromIntegral n
          r = m*10
          aCircle = Circle r
          smallerCircles = circles (n-1)

picture :: Float -> Picture                      -- an animation is a picture that depends on time
picture time = circles n                         -- create a circle every second
    where n = floor time

main =  animate
    ( InWindow
        "Recursion"
        (500, 650)
        (20,  20) )
	white
    picture

