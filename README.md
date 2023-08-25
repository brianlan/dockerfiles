# 简介

汇总常用的不同环境的Dockerfile在这个仓库。

Airflow未来是否能丝滑运作也有赖于这个仓库的良好维护。

# 编译Docker镜像

| 镜像   |      最新版本tag      |  编译方法 |
|----------|--------------|-------|
| Cyclops环境 |  cyclops-env:cuda11.3-ubuntu20.04 | sh build_cyclops_env.sh |
| Airflow Executor基础 |    airflow-executor-base:0.0.1   |   sh build airflow_executor_base.sh |
