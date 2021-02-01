## Cellplot shiny app

This app has been developed to work inside a docker container (Dockerfile file available [here](https://github.com/mpg-age-bioinformatics/shiny)).

To use this app locally you need start the container with:
```bash
docker run --rm -p 3838:3838 --name histogram mpgagebioinformatics/shiny-histogram
```
Access the app on your browser over [http://localhost:3838/histogram](http://localhost:3838/histogram).

The container can be stopped and the container removed with:
```bash
docker stop histogram && docker rm histogram
``` 
Removing the image once you've stopped the container:
```bash
docker rmi histogram
```
