-- | Display some things with types in a window.
--
import Graphics.Gloss

helloworld :: Picture               -- the text is a type of picture
helloworld = Text "Hello World"     -- text to display

smallCircle :: Picture              -- the circle is a type of picture
smallCircle = Circle 10             -- a circle to display

triangle :: Picture                 -- the triangle is a type of picture
triangle = Polygon trianglePath     -- a triangle to display

trianglePath :: Path                -- the trianglePath is a type of path
                                    -- which is the same as a list of points
trianglePath = [ (0, 0)
               , (0, -100)
               , (-100, 0) ]

pictureSet :: Picture               -- pictures are also a picture!
pictureSet = Pictures [ helloworld
                      , smallCircle
                      , triangle ]

main = display 
        (InWindow
           "Hello World"     -- window title
        (400, 150)   -- window size
        (10, 10))    -- window position
    white            -- background color
    pictureSet       -- picture to display

