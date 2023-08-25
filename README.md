# 简介

汇总常用的不同环境的Dockerfile在这个仓库。

Airflow未来是否能丝滑运作也有赖于这个仓库的良好维护。

# 编译Docker镜像

### Cyclops环境 (cyclops-env:cuda11.3-ubuntu20.04)

```bash
sh build_cyclops_env.sh
```

### Airflow Executor基础镜像 (airflow-executor-base:0.0.1)

```shell
sh build airflow_executor_base.sh
```