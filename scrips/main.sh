## Clean data
hive -f cleandata.sql

## R modeling

hive -e "SELECT * from chiffon.chiffon__company3" > ../data/train.txt

R -f train.R


## pySpark
pyspark try.py