

This won't run on lab.analyticsdojo.com.

To execute this you can use docker.  For example, with docker installed run this:

```
docker run -p 8888:8888  -e GRANT_SUDO=yes  --name analyticsdojo_pyspark  -v /Users/jasonkuruzovich/githubdesktop/0_class:/home/jovyan/work jupyter/pyspark-notebook
```

Alternately, sign up for a Databricks community edition account.


Python Gentle Introduction. 
https://docs.databricks.com/_static/notebooks/gentle-introduction-to-apache-spark.html

Data Scientists
https://docs.databricks.com/spark/latest/gentle-introduction/for-data-scientists.html#databricks-for-data-scientists

Word Count
https://www.youtube.com/watch?v=UekrdX_klgk
https://github.com/spark-mooc/mooc-setup/blob/master/ML_lab2_word_count_student.ipynb
