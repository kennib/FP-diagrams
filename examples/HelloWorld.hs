-- | Display "Hello World" in a window.
--
import Graphics.Gloss

picture = Text "Hello World"     -- text to display

main = display 
        (InWindow
           "Hello World"     -- window title
        (400, 150)   -- window size
        (10, 10))    -- window position
    white            -- background color
    picture          -- picture to display

