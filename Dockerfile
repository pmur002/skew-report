
# Base image
FROM ubuntu:16.04
MAINTAINER Paul Murrell <paul@stat.auckland.ac.nz>

# add CRAN PPA
RUN apt-get update && apt-get install -y apt-transport-https
RUN echo 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial/' > /etc/apt/sources.list.d/cran.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Install additional software
# R stuff
RUN apt-get update && apt-get install -y \
    xsltproc \
    r-base=3.4* \ 
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    bibtex2html \
    subversion 

# For building the report
RUN Rscript -e 'install.packages(c("knitr", "devtools"), repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("xml2", "1.1.1", repos="https://cran.rstudio.com/")'

# Other software used in the report
RUN apt-get update && apt-get install -y \
    texlive-metapost \
    ps2eps \
    imagemagick

# Packages used in the report.
RUN Rscript -e 'library(devtools); install_version("XML", "3.98-1.11", repos="https://cran.rstudio.com/")'
COPY grImportOLD_0.9-1.tar.gz /tmp/grImportOLD_0.9-1.tar.gz
RUN R CMD INSTALL /tmp/grImportOLD_0.9-1.tar.gz

# The main report package(s)
COPY grImport_0.9-2.tar.gz /tmp/grImport_0.9-2.tar.gz
RUN R CMD INSTALL /tmp/grImport_0.9-2.tar.gz

