# Making a container to send dogstatsd metrics, logs or traces.

1. Clone this repo or copy the files with the same directory structure:
   ```
   Home DIR >
            > Dockerfile
            > scripts
                     > main.sh
                     > apm.sh
2. Change the permission of the scripts:
   `chmod -R 744 scripts

3. Build the docker image: 

   `docker build -t image_name:image_tag <Home DIR>`

4. Create and run a container using the image:


   ```
   docker run -d \
     --name test \
     -e DOGSTATSD_ENABLE=true \
     -e DOGSTATSD_HOST=<Agent IP> \
     -e LOGS_ENABLE=true \
     -e APM_ENABLE=true \
     -e APM_AGENT_HOST=<Agent IP> \
     -l com.datadoghq.ad.logs='["service":"test","source":"test"]' \
   image_name:image_tag
   
   
5. Sample Agent installation command:

   ```
   DOCKER_CONTENT_TRUST=1 docker run -d \
   --name dd-agent \
   -v /var/run/docker.sock:/var/run/docker.sock:ro \
   -v /proc/:/host/proc/:ro \
   -v /sys/fs/cgroup/:/host/sys/fs/cgroup:ro \
   -e DD_API_KEY=<API_KEY> \
   -e DD_SITE="datadoghq.com" \
   -e DD_LOGS_ENABLED=true \
   -e DD_DOGSTATSD_NON_LOCAL_TRAFFIC=true \
   -p 8126:8126/tcp \
   -p 8125:8125/udp \
   datadog/agent:7
   
---

# Pushing the image to Dockerhub

1. Log-in to Dockerhub:
   ```
   docker login
   
2. Tag the test image with your dockerhub repo name:
   ```
   docker tag <image_id> <repo_name>/<image_name>:<image_tag>
    
3. Push the image to Dockerhub:
   ```
   docker push <repo_name>/<image_name>:<image_tag>
   
