
my_pass <- readr::read_lines("/home/jmr/gmail_key.txt")

mailR::send.mail(
  from="jmreis15@gmail.com", to = "jmreis15@gmail.com", 
  subject = "test",
  body = "Fooh baah",
  smtp = list(host.name = "smtp.gmail.com",
              port = 587,
              user.name = "jmreis15@gmail.com",
              passwd = my_pass),
  authenticate = T,
  send = T)



