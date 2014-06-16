-- | A function to display different coloured objects.
--
import Graphics.Gloss

house :: Color -> Float -> Picture     -- a house is a picture
                                       -- made from a colour and a point to place it
house color position = paint (place theHouse)
    where theHouse = Polygon [(0,0), (20,0), (20,20), (10, 30), (0, 20)]
          place thing = Translate position 0 thing
          paint thing = Color color thing

houses :: Picture
houses = Pictures [ house red     0
                  , house green   40
                  , house cyan   (-100)
                  , house black   125
                  , house magenta (-30)
                  , house orange  100 ]

picture :: Picture
picture = Pictures [ houses ]

main = display 
        (InWindow
           "Hello World"     -- window title
        (400, 150)   -- window size
        (10, 10))    -- window position
    white            -- background color
    picture          -- picture to display

