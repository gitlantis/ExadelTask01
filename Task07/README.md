# Monnitoring (Task07)

## 1. Zabbix

### 1.1 Install on server, configure web and base

prereqisits:
- nginx
- mysql

to install zabbix used this [documentation](https://www.zabbix.com/download?zabbix=5.0&os_distribution=ubuntu&os_version=20.04_focal&db=mysql&ws=nginx)

![start page](./assets/Screenshot_1.png)

result after configuration
![start page](./assets/after_install.png)

### 1.2 Prepare VM or instances. Install Zabbix agents on previously prepared servers or VM.

```sudo apt update```
```sudo apt install zabbix-agent```

to configure zabbix agent:
```sudo nano /etc/zabbix/zabbix_agentd.conf```
------------------
```sh
#zabbix server address
Server=192.168.10.2

#Specify Zabbix server ( For active checks)
ServerActive=192.168.10.2

#agent's hostname
Hostname=ip-172-31-11-76.eu-central-1.compute.internal
```

```sudo systemctl restart zabbix-agent```
```sudo systemctl status zabbix-agent```

## 2. ELK: Nobody is forgotten and nothing is forgotten.

### 2.1 Install and configure ELK

- Elasticsearch: a distributed RESTful search engine which stores all of the collected data.
- Logstash: the data processing component of the Elastic Stack which sends incoming data to Elasticsearch.
- Kibana: a web interface for searching and visualizing logs.
- Beats: lightweight, single-purpose data shippers that can send data from hundreds or thousands of machines to either Logstash or Elasticsearch.

first of all install java

```sudo apt-get install openjdk-11-jdk wget apt-transport-https curl gnupg2 -y```

#### install elastiksearch

download elasticserch signature
```wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -```

add repository
```echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list```

update repository and install elasticsearch
```sudo apt-get update -y```
```sudo apt-get install elasticsearch -y```

after successfully installation start service and enable it to start at system reboot
```sudo systemctl start elasticsearch```
```sudo systemctl enable elasticsearch```

to check port
```ss -antpl | grep 9200```

or with http request
```curl -X GET http://localhost:9200```

#### install logstash

```sudo apt-get install logstash -y```
```sudo nano /etc/logstash/conf.d/logstash.conf```
copy content of ```logstash.conf``` in to it

```sudo systemctl start logstash```
```sudo systemctl enable logstash```

#### install kibana

```sudo apt-get install kibana -y```
```sudo nano /etc/kibana/kibana.yml```

Changed following lines:
```# set 0.0.0.0 to acces from remote connections```
```server.host: 0.0.0.0``` 
```elasticsearch.hosts: ["http://localhost:9200"]```

```sudo systemctl start kibana```
```sudo systemctl enable kibana```

#### install filebeat

```sudo apt-get install filebeat -y```
```sudo nano /etc/filebeat/filebeat.yml```

Comment out the following lines:
```sh
#output.elasticsearch:
  # Array of hosts to connect to.
#  hosts: ["localhost:9200"]
```

Uncomment the following lines:
```sh
output.logstash:
hosts: ["localhost:5044"]
```

```sudo systemctl start filebeat```
```sudo systemctl enable filebeat```

```sudo filebeat modules enable system```

Next, load the index template with the following command:
```sudo filebeat setup --index-management -E output.logstash.enabled=false -E 'output.elasticsearch.hosts=["localhost:9200"]'```

Finally, verify if Filebeat is shipping log files to Logstash for processing. Once processed, data is sent to Elasticsearch.
```curl -XGET http://localhost:9200/_cat/indices?v```

#### Access Kibana Web Interface
```http://public-ip:5601```


### 2.2 Organize collection of logs from docker to ELK and receive data from running containers


### 2.3 Customize your dashboards in ELK


## 3. Grafana

### 3.1 Install Grafana
### 3.2 Integrate with installed ELK
### 3.3 Set up Dashboards

