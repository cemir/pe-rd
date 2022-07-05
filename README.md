docker build . -t toto
docker image tag toto:latest cemir/ep-rundeck:mvp
docker push cemir/ep-rundeck:mvp 