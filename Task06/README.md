# Jenkins task (Task06)

following you can see jenkins image running on port ```8080```

```docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jenkins/jenkins:lts-jdk11```

![jenkins image](./assets/docker_image.png)

### **Creating docker agets using docker images**

[Container agent documentation](https://www.jenkins.io/doc/book/using/using-agents/)

custom ssh-agent docker files path: ```jenkins-ssh-agent/Dockerfile```

build image: ```docker build --tag="ssh-agent" .```

run docker: 
```docker run -v /var/run/docker.sock:/var/run/docker.sock -d --rm --name=agent1 -p 22:22 -e "JENKINS_AGENT_SSH_PUBKEY=[public key]]" ssh-agent:latest```

created three docker qagents, working on ssh ports 22, 23, 24 

![jenkins image](./assets/agents.png)

### **Freestyle Job**

created freestyle job echoes ```today is ....``` and prints datetime 

**configuration:**

![jenkins image](./assets/build_sh.png)

![jenkins image](./assets/freestyle_job.png)

**result:**

![jenkins image](./assets/result.png)

### **Creating pipeline**

pipeline configuration is in ```jenkins-agents``` file
console log is insid of ```jenkins-agents_log``` file

it prints ```docker ps -a ``` afrter completing every stage.

### **Encrypted variables**

folder ```docker-encrypt``` contains solution from previous task, pushid to 

to run this you must create pipeline project and
you have to speciffy source path ```Task06/docker-encrypt/jenkins-encrypt``` for pipeline

console log result is inside of ```Task06/docker-encrypt/jenkins-encrypt_log```

