#!/bin/bash  
sudo service docker start
sudo docker run --name nginx -d nginx > output.log
cat output.log