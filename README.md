# Examples for Spark application Dependency Management

see related blog post [here](https://blog.kk17.net/post/how-to-extend-spark/)

## Run examples

Need Docker and Docker compose installed.

1. Package

```bash
sbt package
```

2. Run Spark Standalone Cluster

copy `.env.example` to `.env`

```bash
docker-compose up -d
```

3. Run test script

```bash
bash scripts/xxx.sh
```

## Reference

[java - Add jars to a Spark Job - spark-submit - Stack Overflow](https://stackoverflow.com/questions/37132559/add-jars-to-a-spark-job-spark-submit)
