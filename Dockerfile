ARG BASE_CONTAINER=python:3.7.4-slim-buster
FROM $BASE_CONTAINER

# Update and upgrade 
RUN apt-get update && apt-get -y upgrade

# Install necessary packages
RUN apt install -y gcc g++ build-essential curl
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt install -y nodejs

# Set user
USER root

# Install via pip necessary packages
RUN pip install torch==1.2.0+cpu torchvision==0.4.0+cpu -f https://download.pytorch.org/whl/torch_stable.html
RUN pip install awscli \
        black \
        click \
        coverage \
        fastai==1.0.57 \
        flake8 \
        ipywidgets \
        jupyterlab \
        mysql-connector-python \
        plotly \
        pystan \
        python-dotenv>=0.5.1 \
        seaborn \
        scikit-learn \
        Sphinx
RUN pip install fbprophet
RUN export NODE_OPTIONS=--max-old-space-size=4096
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager@1.0 --no-build
RUN jupyter labextension install plotlywidget@1.1.1 --no-build
RUN jupyter labextension install jupyterlab-plotly@1.1.2 --no-build
RUN jupyter lab build
RUN unset NODE_OPTIONS

# Create notebooks folder
RUN mkdir /home/notebooks

# Expose the port
EXPOSE 8888

# Set the wokring directory
WORKDIR /home/notebooks

# Set the entrypoint command
ENTRYPOINT ["jupyter-lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]

