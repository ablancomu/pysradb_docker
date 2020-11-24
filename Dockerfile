FROM python:3.8
MAINTAINER ablancomu@gmail.com
ENV SRP NULL
ENV THREADS 4
ENV INPUT NULL

WORKDIR /home/docker
RUN pip install pandas requests tqdm xmltodict
RUN git clone https://github.com/saketkc/pysradb.git
WORKDIR /home/docker/pysradb
RUN pip install -e .

RUN mkdir -p /home/docker/out
WORKDIR /home/docker/out

COPY ./pysradb.sh /
RUN chmod +x /pysradb.sh

ENTRYPOINT /pysradb.sh


