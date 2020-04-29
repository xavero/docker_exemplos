FROM ubuntu:18.04

# Dependências
RUN apt-get update && apt-get install -y curl

ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

RUN python3 -m pip --no-cache-dir install --upgrade \
    pip \
    setuptools

RUN ln -s $(which python3) /usr/local/bin/python

RUN python3 -m pip install --no-cache-dir tensorflow

RUN python3 -m pip install --no-cache-dir keras

# Arquivo da aplicação
COPY tensorflow.py ./

CMD [ "python3", "tensorflow.py" ]
