# papermc-docker

A Docker image for running a  PaperMC Minecraft server

## Setup

* Build the image ```docker build -t varchar42/papermc .```

* Run it ```docker run -p 25565:25565 varchar42/papermc```
  * With plugins ```docker run -p 25565:25565 -v plugins:/mc_plugins varchar42/papermc```
