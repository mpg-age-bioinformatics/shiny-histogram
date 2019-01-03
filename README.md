## Histogram shiny app

This app has been developed to work inside a docker container (Dockerfile file available [here](https://github.com/mpg-age-bioinformatics/shiny)).

To use this app locally you need to build the respective container and clone this repo:

Build the image:
```bash
cd ~/
mkdir -p shinylogs
git clone https://github.com/mpg-age-bioinformatics/shiny.git
cd shiny
docker build -t shiny .
```
Pull the app:
```bash
cd ~/shiny
git submodule init histogram 
git submodule update histogram 
```
Start the container:
```bash
docker run --rm -p 3838:3838 -p 8787:8787 \
-v ~/shiny:/srv/shiny-server/ \
-v ~/shinylogs:/var/log/shiny-server/ \
--name shiny shiny
```
Access the app on your browser over [http://localhost:3838/histogram](http://localhost:3838/histogram).

### Contributing

To help you with development we have deployed an RStudio server in the main container. 

After starting the container as descrived above you can start the RStudio server:
```bash
docker exec -i -t shiny sudo rstudio-server start
```
You can now access the RStudio server on you browser over [http://localhost:8787](http://localhost:8787) (user/password: mpiage/bioinf). This app can then be found in `/srv/shiny-server/histogram`. If you need to add R libraries make sure you do so in the `requirements.R` file and that those libraries are added to the `/srv/shiny-server/histogram/libs` folder. If you need to add system libraries you can do so by entering the container with:
```bash
docker exec -i -t shiny /bin/bash
```
Make sure any installed libraries are added to the end of the [Dockerfile](https://github.com/mpg-age-bioinformatics/shiny/blob/master/Dockerfile) and that the respective changes are committed.

Please make sure that all files downloaded by the user contain the version tag eg.:
```R
    # specify the output file name
    filename = function(){
      paste0('Histogram.',gitversion(),'.pdf')
    }
```

Stopping the RStudio server:
```bash
docker exec -i -t shiny sudo rstudio-server stop
```
Removing the image once you've stopped the container:
```bash
docker rmi shiny
```
Submitting your changes to the repo's app:
```bash
cd ~/shiny/histogram
git add .
git commit -m "<describe your changes here>"
git push origin HEAD:master
```
And then tell the main project to start tracking the updated version:
```bash
cd ~/shiny
git add histogram
git commit -m histogram
git push
```
