ARG BASE_CONTAINER=python:3.7.4-slim-buster
FROM $BASE_CONTAINER

# Update Ubuntu Software repositiory
RUN apt-get update && apt-get -y upgrade
#RUN apk add cur
RUN apt install -y gcc g++ build-essential curl
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt install -y nodejs
USER root
# Install pip
#all
#RUN pip3 --version

#RUN pip3 install --upgrade pip

# Echo pip version
#RUN pip --version
#RUN python3 --version
#RUN curl -O https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh
#RUN sh Anaconda3-5.2.0-Linux-x86_64.sh

#RUN conda install -y pytorch torchvision cpuonly -c pytorch

# Install via pip torch and tochvision
RUN pip install torch==1.2.0+cpu torchvision==0.4.0+cpu -f https://download.pytorch.org/whl/torch_stable.html

##
### Install via pip the rest of the needed packages
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
#RUN jupyter labextension install jupyterlab-chart-editor@1.2 --no-build
RUN jupyter lab build
RUN unset NODE_OPTIONS

RUN mkdir /home/notebooks

VOLUME ["/home/notebooks"]

EXPOSE 8888

ENTRYPOINT ["jupyter-lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]

