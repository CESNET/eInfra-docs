#!/bin/bash

print_usage() {
  printf "Usage: Just run ./start.sh\n"
  printf "  -p : pull image before running it\n"
  printf "  -b : build own image\n"
}

DOCKER_BIN=${DOCKER_BIN:-"docker"}
# DOCS_IMAGE="it4innovations/docker-mkdocscheck"
# DOCS_IMAGE="einfra/mkdocs-test"
DOCS_IMAGE="hub.cerit.io/einfracz/mkdocs:latest"

while getopts 'pbh' option
do
case "${option}"
in
p) ${DOCKER_BIN} pull "$DOCS_IMAGE" && ${DOCKER_BIN} image prune -f ;;
b) ${DOCKER_BIN} build -t e-infra_mkdocs:latest . ;;
h) print_usage
   exit 1 ;;
esac
done
shift $OPTIND-1

${DOCKER_BIN} run -it --rm \
	-v ${PWD}:/docs:z \
	-p 8080:80 \
  -e SITE_VERSION="rev. development / "$(env TZ=Europe/Prague date -I) \
	${DOCS_IMAGE} serve -a 0.0.0.0:80 $@
