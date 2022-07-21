docker build --network=host -t idc-5:5000/transwarp/mylab:v1 .
#docker build --network=host --no-cache -t idc-5:5000/transwarp/mylab:v1 .
docker push idc-5:5000/transwarp/mylab:v1
