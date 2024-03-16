# Function to build and push docker images
# edit host
add_hosts() {
    echo "Adding hosts"
    #sudo bash -c 'echo "127.0.0.1       mp3converter.com" >> /etc/hosts'
    #sudo bash -c 'echo "127.0.0.1       rabbitmq-manager.com" >> /etc/hosts'
}

build_and_push_images() {
    local services=( "auth" "converter" "gateway")
    cwd=$(pwd)
    for service in "${services[@]}"
    do
        echo "Building and pushing docker image for $service"
        cd src/$service
        docker build -t $service .
        docker tag $service:latest simonprudhomme/$service:latest
        docker push simonprudhomme/$service:latest
        cd $cwd
    done
}

# Function to delete manifest files
delete_manifests() {
    local services=( "auth" "converter" "gateway" "rabbit", "mongodb")
    for service in "${services[@]}"
    do
        echo "Deleting manifest files for $service"
        kubectl delete -f src/$service/manifests
    done
}

# Function to build manifest files
build_manifests() {
    local services=( "auth" "converter" "gateway" "rabbit",  "mongodb")
    for service in "${services[@]}"
    do
        echo "Building manifest files for $service"
        kubectl apply -f src/$service/manifests
    done
}

k8s_scale_up() {
    local services=( "auth" "converter" "gateway" "rabbit")
    for service in "${services[@]}"
    do
        echo "Scaling down $service"
        kubectl scale deployment --replicas=2 $service
    done
}

k8s_scale_down() {
    local services=( "auth" "converter" "gateway" "rabbit")
    for service in "${services[@]}"
    do
        echo "Scaling down $service"
        kubectl scale deployment --replicas=1 $service
    done
}

# warning: this is a hack
rabbitmq() {
    echo "Dont forget to add the rabbitmq queues: video and mp3"
    }

# tunnel to minikube
tunnel(){
    echo "Dont forget to add the run : minikube tunnel"
}

if [ "$1" == "build-docker" ]; then
    build_and_push_images
elif [ "$1" == "delete-manifest" ]; then
    delete_manifests
elif [ "$1" == "build-manifest" ]; then
    build_manifests
elif [ "$1" == "all" ]; then
    build_and_push_images
    delete_manifests
    build_manifests
    add_host
    k8s_scale_up
    rabbitmq
    tunnel
elif [ "$1" == "tunnel" ]; then
    tunnel
elif [ "$1" == "scale-down" ]; then
    k8s_scale_down
elif [ "$1" == "scale-up" ]; then
    k8s_scale_up
elif [ "$1" == "add-host" ]; then
    add_hosts
else
    echo "Invalid argument"
fi
