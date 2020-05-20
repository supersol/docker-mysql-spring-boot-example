# Task solution steps

1. I worked with zabbix, prometheus, influx and elastic stacks, created simple monitoring script `check_elastic.sh`  
In elastic we can also use "elast alert" functionality  

2. Updated `Dockerfile` to use multistage build for producing artifact  

3. I prebuilt app image on my own local kubernetes cluster nodes and set `imagePullPolicy` to not deal with spinning up registry  

4. Created `spring_app.yaml` with service, deployment for springboot application.  

5. Created local `StorageClass`, `PersistentVolume`, `PersistentVolumeClaim`, `Secret` and `StatefulSet` for deploying mysql
Respectful files: `sc.yaml`, `pv_sts.yaml`, `secrey.yaml`, `mysql_sts.yaml`  
Due to using only my local resources I found this way pretty convenient.

6. Created `ns.yaml`, with namespaces in case multi env deployment  

7. Deployed spring app with liveness probe.

Answers for further questions:

####DB HA setup:

The architecture of HA setup depends on overall db usage.  
General strategy is to have master and multiple readers, where master will only do writes and do replication on reader,
readers only responsible for read data.  
Installation should be monitored carefully for rps, connections, cpu/memory, diskio, replication lag  
In case of master failure there is a possibility to switch to reader and make it new master  
Switchover can be done in automatic way but requires special attention  
In some cases might be wise to do switching manually  

In kubernetes ecosystem in can be done with for example 2 stateful sets: 1 for master, 1 for readers with multiple replicas baked with some scripts for monitoring/failover activities  

####CI:

We can create jenkins pipeline with some artifact building, unit tests, validation, dry-run of yaml templates also it can be more complex with additional checks depending on the CI process.    
Automatically deploy service to testing environments, do whole cycle of tests(integration, stress, etc).  

####Multi env deploy:

We can achieve this using namespaces in 1 cluster or if we have multiple clusters we can switch context for `kubectl` in jenkins job for example

####Monitoring:

Prometheus managed by kubernetes prometheus-operator, grafana and alertmanager which can be intergrated with slack, opsgenie, etc.
