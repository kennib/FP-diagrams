-- | Display a transformation of "Hello World" in a window.
--
import Graphics.Gloss

helloworld = Text "Hello World"     -- text to display

picture0 = Rotate 180 helloworld                 -- transform the text
picture1 = Translate (-800) (-20) helloworld     -- transform the text
picture2 = Color green helloworld                -- transform the text

main = display 
        (InWindow
           "Hello World"     -- window title
        (400, 150)   -- window size
        (10, 10))    -- window position
    white            -- background color
    picture0         -- picture to display

