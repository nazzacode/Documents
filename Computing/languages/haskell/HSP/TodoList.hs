-- Simple Todo List Implementation

type Item = String
type Items = [Item]

data Command = Quit | DisplayItems | AddItem String

parse Command :: String -> Either String Command
parse Command line = case words line of 
  ["quit"]             -> Right Quit
  ["items"]            -> Right DisplayItems
  "add" : "-" : item   -> Right (AddItem (unwords item))
  _                    -> Left "Unknown command."

-- Returns new list of Items with new item in it
addItem :: Item -> Items -> Items
addItem item items = item : items

-- Returnds a string representation of the items
displayItems :: Items -> String
displayItems items = 
  let
    displayItem index item = show index ++ " - " ++ item
    reversedList = reverse items
    displayedItemsList = zipWith displayItem [1..] reversedList
  in
    unlines displayedItemsList
    
-- Return a new list of items or a error message if the index is out of range
-- removeItem :: Int -> Items -> Either String Items 

-- Takes a list of items
-- interacts with the user
-- return an updated list of items 
interactWithUser :: Items -> IO Items
interactWithUser items = do 
  putStrLn "Enter an item to add to your todo list:"
  item <- getLine
  case parseCommand line of
    Right DisplayItems -> do
      putStrLn "The List of items is:"
      putStrLn (displayItems items)
      interactWithUSer newItems

    Right (AddItem item) -> do 
      let new Items = addItem item items
      putStrLn "Item added."
      interactWithUser newItems

    Right Quit -> do 
      putStrLn "Bye"
      pure()

    Left errMsg -> do 
      putStrLn ("Error: " ++ errMSg)
      interactWithUSer items

main :: IO ()
main = do 
  putStrLn "TODO app"
  let initiateList = []
  interactWithUser initiateList
  putStrLn "Thanks for using this app"


