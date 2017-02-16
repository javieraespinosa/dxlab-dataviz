
# dxlab-dataviz

Docker container + material for the course [Big Data Visualization](http://espinosa-oviedo.com/big-data-visualization). 

### Execution

The following instruction prepare the container for executing all exercises: 

```sh
# PATH containing the hands-on folder 
export DXLAB_HOME=(pwd)  

docker run       \
   -v DXLAB_HOME:/root/  \
   -p 8008:8008  \
   -p 8888:8888  \
   -p 27021-27023:27021-27023  \
   -it dxlab/dataviz
```
