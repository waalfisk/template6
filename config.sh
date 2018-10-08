#!/bin/bash

#cosmetic stuff
hline=$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)

#check if docker is online
aw=$(docker stats --no-stream)
if [ -z "${aw}" ]; then
    echo "Your docker daemon is offline. Please start your docker daemon first!"
    echo "Call On MacOS: 'open /Applications/Docker.app'"
    exit 1
fi

#load settings
source config.conf

#get and goto current directory (required to keep relative links working)
folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd "${folder}"

#abort if no subcommands given
if [ $# -lt 1 ]; then
    echo "no subcommands supplied."
    echo "Usage: ./$0 {run|start|uninstall}"
    exit 1
fi


#loop over all arguments
for inarg in "$@"; do 
#for each $inarg do case-switch
case "${inarg}" in
run)
    echo $hline
    echo "Create data container '${datacontainer}' if not exist"
    docker volume create "${datacontainer}"
    echo "Instantiate container '${containername}' from the '${mongoimage}:${mongoversion}' image now"
    docker run -it \
        --name "${containername}" \
        -v "${datacontainer}:/data" \
        -p "${containerport}:27017" \
        -d "${mongoimage}:${mongoversion}" --smallfiles
    echo "*** Container Instantiation Completed ***"
    ;;
start)
    #no fancy echo/print messages
    docker start ${containername} #use -a to see logs
    ;;
uninstall)
    echo $line
    echo "Delete '${containername}' now"
    docker stop ${containername}
    docker rm ${containername}
    echo "*** Container deleted ***"
    echo "    Type 'docker rmi ${mongoimage}:${mongoversion}' to delete the base image."
    echo "    Type 'docker volume rm ${datacontainer}' to delete the data volume."
    ;;
*)
    echo "Usage: ./$0 {run|start|uninstall}"
    exit 1
esac #end case-switch
done #end for-loop

#successfully done
exit 0
