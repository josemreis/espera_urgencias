######################################################################################

# file: set_up.R

# date: 23/03/2020

######################################################################################

### Packs
library(git2r)

### Create the directories
if (!dir.exists("data")) {
  
  dir.create("data")
  
}


if (!dir.exists("scripts")) {
  
  dir.create("scripts")
  
}


## testing git. Try with git2r test 3