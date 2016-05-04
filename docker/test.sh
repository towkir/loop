    #!/bin/bash -e
    # WARNING: this is experimental mileage may vary!

    # Image appears to be a Docker Hub Image. Fetch docker image
    image_name=docker-loop
    #docker pull 'quay.io/mrrrgn/ubuntu-ci:0.0.1'

    # Find a unique container name
    container_name='task-HId0IKpkSt-w-bpAGwBMeQ-container'

    # Run docker command
    docker run -ti \
      --name "${container_name}" \
      -e GITHUB_EVENT='push' \
      -e GITHUB_BRANCH='taskcluster-experimental' \
      -e GITHUB_BASE_BRANCH='taskcluster-experimental' \
      -e GITHUB_HEAD_REPO_URL='https://github.com/mozilla/loop.git' \
      -e GITHUB_HEAD_USER='Standard8' \
      -e GITHUB_HEAD_SHA='2e4aab4b38738aa3f0ccb64dc6bbeca3bff0d384' \
      -e GITHUB_HEAD_BRANCH='taskcluster-experimental' \
      -e GITHUB_HEAD_USER_EMAIL='Standard8@noreply.github.com' \
      -e RUN_LOCALLY='true' \
      -p 5900 \
      ${image_name} \
      #/bin/bash -l -c 'echo hello'

# && git clone https://github.com/mozilla/loop.git repo && cd repo && git checkout taskcluster-experimental && mozdownload --type=daily --branch=mozilla-central && tar xfj *.bz2 && TEST_BROWSER=`pwd`/firefox/firefox TEST_SERVER=dev make functional"
# git clone https://github.com/mozilla/loop.git repo && cd repo && git checkout taskcluster-experimental && mozdownload --type=daily --branch=mozilla-central && tar xfj *.bz2
# TEST_BROWSER=`pwd`/firefox/firefox TEST_SERVER=dev make functional"
    # Delete docker container
    docker rm -v "${container_name}"
