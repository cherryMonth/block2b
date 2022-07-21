FROM  nvidia/cuda:9.2-cudnn7-devel-ubuntu16.04

RUN apt-get update --allow-unauthenticated  \
    && apt install software-properties-common -y \
    && add-apt-repository -y ppa:jblgf0/python \
    && apt-get update --allow-unauthenticated \
    && apt install python3.8-distutils  python3.8 curl -y \
    && apt-get install build-essential libssl-dev libffi-dev python3-dev -y \
    && ln -s /usr/bin/python3.8 /usr/bin/python3 -f \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py  -i https://pypi.tuna.tsinghua.edu.cn/simple \
    && ln -s /usr/local/bin/pip3 /bin/pip

ADD notebook.sh  /bin/notebook.sh
