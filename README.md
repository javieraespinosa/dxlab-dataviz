
# dxlab-dataviz

Docker container and material for the course [Big Data Visualization](http://espinosa-oviedo.com/big-data-visualization). 

### Installation

```sh
docker pull dxlab/dataviz

git clone https://github.com/javieraespinosa/dxlab-dataviz.git
cd dxlab-dataviz
rm README.md Dockerfile

DXLAB_HOME=$(pwd)
```

### Execution

```sh
docker run       \
   -v $DXLAB_HOME:/root/  \
   -p 22:22      \
   -p 8008:8008  \
   -p 8888:8888  \
   -p 27021-27023:27021-27023  \
   -it dxlab/dataviz
```
