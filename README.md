# jupyterlab-aareguru-docker

## Precondition
Docker needs to installed. For help check: https://docs.docker.com/install/

## Run
Start the container at the root of the aare-guru git folder (see https://gitlab.com/fri-ml/aareguru-forecast):
`docker run -d -it -p [PORT]:8888 -v [AARE-GURU-FOLDER]:/home/notebooks --name jupyterlab cybernemo/jupyterlab-aareguru`
