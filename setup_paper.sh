#!/bin/bash

PLUGINS_FOLDER="/mc_plugins"

URL=https://papermc.io/api/v2/projects/paper

if [ ${MC_VERSION} = latest ]; then
    MC_VERSION=$(curl -s $URL | jq -r '.versions[-1]')
fi

URL=${URL}/versions/${MC_VERSION}
PAPER_BUILD=$(curl -s $URL | jq '.builds[-1]')

JAR_NAME=paper-${MC_VERSION}-${PAPER_BUILD}.jar
URL=${URL}/builds/${PAPER_BUILD}/downloads/${JAR_NAME}

echo "Using MC version ${MC_VERSION} and build ${PAPER_BUILD}."

if [ ! -e ${JAR_NAME} ]; then
    rm -f *.jar
    curl -O ${URL}
    echo eula=true > eula.txt
fi

if [ -d "${PLUGINS_FOLDER}" ]; then

    if [ -d "plugins" ]; then
        rm -f plugins/*.jar
    else
        mkdir plugins
    fi

    echo "Creating symlinks for plugins ..."

    for file in ${PLUGINS_FOLDER}/*.jar; do
        echo "  * $file"
        ln -s $file plugins
    done
    
fi


if [ ! -z "${JVM_RAM}" ]; then
    JVM_ARGS="-Xmx${JVM_RAM} ${JVM_ARGS}"
fi

if [ "${DEBUG}" == "true" ]; then
    exec /bin/sh
else
    exec java ${JVM_ARGS} -jar ${JAR_NAME} nogui
fi
