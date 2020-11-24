# Download samples from SRA with pysradb and docker

This is a wrapper in Docker of the python package *__pysradb__* :

> _Choudhary, Saket_. __“pysradb: A Python Package to Query next-Generation Sequencing Metadata and Data from NCBI Sequence Read Archive.”__ F1000Research, vol. 8, F1000 (Faculty of 1000 Ltd), Apr. 2019, p. 532 (https://f1000research.com/articles/8-532/v1)

# Requirements
1. Docker

# Install

```
git clone https://github.com/ablancomu/pysradb_docker.git
cd pysradb_docker
docker build -t pysradb .
```

# Usage

Let's take the __SRP256479__ study as example:

### Case 1: Download all the files from SRP256479

```
docker run --rm -it -v /path/to/repo/pysradb_docker:/home/docker/out -e SRP='SRP256479' -e THREADS='8' pysradb
```
The __THREADS__ is an env variable to select the number of cores to download the study samples. If is not provided, the default is set to 4 cores.

### Case 2: Download a subset of samples from one study

```
docker run --rm -it -v /path/to/repo/pysradb_docker:/home/docker/out -e SRP='SRP256479' -e INPUT='subset.txt' -e THREADS='8' pysradb
```

The _subset.txt_ file should be plain text with one SRS/SRR code per line, whithout header. The github repository comes with an example file `sra_sampleID.txt` 

# Outputs

The wrapper creates in the `/path/to/repo/pysradb_docker` a folder called `pysradb_downloads` with all the SRA files of the samples. It also saves a table with the metadata of the downloaded samples.

# Limitations

Currently the wrapper can be used just for:
1. Download all files from a study (SRP accession id)
2. Download a subset of samples from one study

In both cases, a table with the respective metadata is generated.
To access all the *__pysradb__* functions, the user should execute the pysradb docker image changing the --entrypoint to bash, so the program can be used interactively inside the container.
