# Jenkins task (Task06)

following you can see jenkins image running on port ```8080```

```docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11```

![jenkins image](./assets/docker_image.png)
### **Freestyle Job**

created freestyle job echoes ```today is ....``` and prints datetime 

**configuration:**

![jenkins image](./assets/build_sh.png)

![jenkins image](./assets/freestyle_job.png)

**result:**

![jenkins image](./assets/result.png)


to create docker agents we have to install ```docker pipeline``` plugin

