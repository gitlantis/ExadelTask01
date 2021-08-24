# Jenkins task (Task06)

following you can see jenkins image running on port ```8080```

```docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11```

![jenkins image](./assets/docker_image.png)

### **Creating docker agets using docker images**
to create docker agents we have to install ```docker pipeline``` plugin
three agens agents creationscript is inide of ```jenkins_agents```
1. ```nginx```
2. ```node```
3. ```mysql```

after running each agent prints own version 

log file is inside of ```jenkins_agents_log.txt```

### **Freestyle Job**

created freestyle job echoes ```today is ....``` and prints datetime 

**configuration:**

![jenkins image](./assets/build_sh.png)

![jenkins image](./assets/freestyle_job.png)

**result:**

![jenkins image](./assets/result.png)

### ****

