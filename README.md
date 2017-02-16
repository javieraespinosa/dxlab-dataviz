
# dxlab-dataviz

Docker container and material for the course [Big Data Visualization](http://espinosa-oviedo.com/big-data-visualization). 


### Installation

```sh
git clone https://github.com/javieraespinosa/dxlab-dataviz.git

```

### Execution

Configuration for running all exercises: 

```sh
# Folder containing the hands-on material
cd dxlab-dataviz
export DXLAB_HOME=(pwd)  

docker run       \
   -v DXLAB_HOME:/root/  \
   -p 8008:8008  \
   -p 8888:8888  \
   -p 27021-27023:27021-27023  \
   -it dxlab/dataviz
```
