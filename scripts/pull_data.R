#!/usr/local/bin/Rscript
######################################################################################

# file: pull_data.R

# date: 24/03/2020

######################################################################################
### Setting things up
###-----------------------------------------------------------------------------------

cat("\n>> Setting things up\n")

## Conditional instalation of the packages
packs <- c("remotes", "tidyverse", "git2r","esperaR", "mailR")
for (pack in packs) {
  
  if (!requireNamespace(pack, quietly = TRUE)) {
    
    if (pack == "esperaR"){
      
      remotes::install_github("josemreis/esperaR")
      
    } else {
      
      install.packages(pack)
      
    }
  }
}

## load the packages
require(git2r)
require(esperaR)
require(stringr)
require(readr)


## Working directory at file location
# wd at file location
setwd("/home/jmr/Dropbox/datasets_general/espera_urgencias")

### Pull urgency data
###---------------------------------------------------------------------
## create the file name and check if it exists
filename <- paste0("./data/", str_replace_all(Sys.time(), "\\:|\\s+", "_"), ".csv")

if (!file.exists(filename)) {
    
  cat(paste0("\n>> Collecting wait times data: ", Sys.time(), "\n"))

  # read in email for request headers and bug mails
  my_email <- read_lines("/home/jmr/my_gmail.txt")
  
  ## make the API call using esperaR::get_wait_times()
  er_dta <- try(get_wait_times_all(output_format = "data_frame",
                               request_headers = c(from = my_email),
                               data_type = "emergency",
                               sleep_time = 3), silent = TRUE)
  
  if (class(er_dta) == "try-error") {
    
    ## notify
    mailR::send.mail(
      from = my_email, to = my_email, 
      subject = paste0("Error at ", Sys.time()),
      body = paste0("At ", Sys.time(), " the code stopped working.\n", "Error message:\n", er_dta[1]),
      smtp = list(host.name = "smtp.gmail.com",
                  port = 587,
                  user.name = my_email,
                  passwd =  readLines("/home/jmr/gmail_key.txt"),
                  ssl = TRUE),
      authenticate = T,
      send = T)
    
  } else {
    
    cat("\n>> Exporting\n")
   
    ## export it
    write_csv(er_dta,
              path = filename)
    
    ## push it to github 
    
    cat("\n>> Pushing to github\n")   
 
    # comit message
    commit_msg <- paste0("added ", filename)
    
    # stage and commit changes
    add(repo = ".",
        path = filename)
    
    commit(repo = ".", 
           message = commit_msg,
           all = TRUE)
    
    ## push it
    push(object = ".",
         credentials = cred_user_pass(username = "josemreis",
                                      password = readLines("/home/jmr/github_pass.txt")))
    
  }
}
