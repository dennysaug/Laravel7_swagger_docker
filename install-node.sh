#!/bin/bash

if [ ! -d $(pwd)/node_modules ]; then
#    chmod 777 -R /home/node/app && \
#    su node && \
    npm install && \
#    exit && \
    npm install vue-router && \
#    su node && \
    npm audit fix --force && \
    npm install vuex --save && \
    npm rebuild
fi

npm run watch

#docker exec php1 useradd dennys -d /home/dennys
#docker exec -it php1 /bin/bash
#su dennys





# remove all
# docker container prune -f && docker rmi $(docker images -q) -f && sudo rm -rf vendor/ .env
