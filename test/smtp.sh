#!/bin/bash

email=kinko-test@open-lab.org
password=4002f502

smtp.socket_type=SSL

swaks --tls-on-connect -4 \
  --auth plain --auth-user $email --auth-password $password \
  --server smtp.googlemail.com --port 465 \
  --quit-after AUTH

else

  swaks --tls -4 \
    --auth plain --auth-user $email --auth-password $password \
    --server smtp.googlemail.com --port 587 \
    --quit-after AUTH
  
end