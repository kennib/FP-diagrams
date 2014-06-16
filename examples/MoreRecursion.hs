-- | Display an animation of recursion.
--
import Graphics.Gloss

tree :: Integer -> Picture                    -- this function creates a tree of a certain depth
tree 0 = Blank                                -- a tree with no depth appears as a blank picture
tree n = Pictures [ branch                    -- a tree with some depth is a branch
                                              -- with two smaller trees poking out of either side
                  , Rotate branchAngle    (Translate 0 (branchLength/2) subTree)
                  , Rotate (-branchAngle) (Translate 0 (branchLength/2) subTree) ]

    where subTree = Scale 0.5 0.5 (tree (n-1))
          branch = rectangleSolid branchWidth branchLength
          branchLength = 50
          branchWidth = 8
          branchAngle = 30


picture time = tree n            -- increase the depth of the tree every second
    where n = min 8 (floor time) -- don't go above a depth of 8

main =  animate
    ( InWindow
        "More Recursion"
        (500, 650)
        (20,  20) )
	white
    picture

