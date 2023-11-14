# On se sert du système ubuntu
FROM ubuntu:latest AS ubnt
# On exexute apt update pour mettre les packages de l'os a jour et l'installation de tous éléments de bases
RUN apt -y update && apt install python3.11 -y &&  apt install curl -y && apt install pip -y &&  pip install redis &&  pip install requests &&  pip install flask

COPY . .

COPY --from=ubnt /usr/bin/python3 /usr/bin/python3
COPY --from=ubnt /usr/bin/pip3 /usr/bin/pip3
COPY --from=ubnt /usr/bin/curl /usr/bin/curl
COPY --from=ubnt /etc/redis /etc/redis
#requests
COPY --from=ubnt /etc/redis/redis-server /etc/redis/redis-server
#flask
COPY --from=ubnt /usr/local/lib/python3.11 /usr/local/lib/python3.11

# On copie les fichiers dans le répertoire du container
COPY voting-app/azure-vote /app

# Ce paragraphe est la décomposition du one line au dessus
# On installe python
#RUN apt -y update && apt install python3 -y
# On installe redis server
#RUN apt install -y redis-server -y
# On installe curl
#RUN apt -y update && apt install curl -y
# On installe pip
#RUN apt -y update && apt install pip -y
# On installe redis
#RUN apt -y update && pip install redis
# On installe la librairie requests
#RUN apt -y update && pip install requests
# On installe la librairie flask
#RUN apt -y update && pip install flask

# On définit les variables d'environnement pour le serveur REDIS
ENV REDIS=
ENV REDIS_PWD=

# Je sais pas à quoi ça sert
# WORKDIR /Users/auguste/Documents/Cours/DevOps/24102023/voting-app

# On ouvre le port 8080
EXPOSE 8080

# On vérifie si la connexion a pu être établie
HEALTHCHECK CMD curl --fail http://localhost:8080 || exit 1

# On lance l'application
CMD ["python3", "/app/main.py"]
