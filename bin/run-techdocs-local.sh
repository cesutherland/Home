#!/bin/bash

# NAME
#   run-techdocs-local.sh - invokes the techdocs-preview-local docker image to generate a site from Backstage documentation and
#   serve it
#
# SYNOPSIS
#   run-techdocs-local.sh --verbose --catalog-file=PATH --port=NUMBER --entity-directory=PATH
#
# DESCRIPTION
#   Parses command line arguments and runs the techdocs-preview-local docker image to generate a site from Backstage documentation and
#   serve it

# bash strict mode
set -euo pipefail

# constants
IMAGE_NAME=artifactory.squarespace.net/squarespace/backstage/backstage-techdocs-preview-local
IMAGE_TAG=latest

# flag default values
VERBOSE=false
PORT=7007
CATALOG_FILE=""
ENTITY_DIRECTORY=$(pwd)

# check_prerequisites ensures that all programs needed to run this script are
# installed. It will fatally exit the script if one of the prerequites are not
# found.
check_prerequisites() {
    reqs=("basename" "readlink" "docker")
    for req in "${reqs[@]}"; do
        command -v "$req" &>/dev/null || {
            echo "Requirement $req not found. Install it and try again"
            exit 1
        }
    done
}

# help provides usage information
help() {
    echo "Usage: $(basename $0) [OPTIONS]"
    echo
    echo "Options:"
    echo "--verbose                 Enable verbose mode"
    echo "--port=[NUMBER]           Set port to [NUMBER]. Default: 7007"
    echo "--catalog-file=[PATH]     Set path of the catalog file to [PATH]. Script will search if none provided"
    echo "--entity-directory=[PATH] Set path of the entity directory to [PATH]. Default: Current directory ($(pwd))"
}

# parse_flags parses command line flags. Prints the help output if an invalid flag is passed
parse_flags() {
    while (( "$#" )); do
    case "$1" in
        --verbose)
            VERBOSE=true
            shift
            ;;
        --verbose=*)
            VERBOSE="${1#*=}"
            shift
            ;;
        --port=*)
            PORT="${1#*=}"
            shift
            ;;
        --catalog-file=*)
            CATALOG_FILE="${1#*=}"
            shift
            ;;
        --entity-directory=*)
            ENTITY_DIRECTORY="${1#*=}"
            shift
            ;;
        --help)
            help
            exit 0
            shift
            ;;
        --) # end argument parsing
            shift
            break
            ;;
        -*|--*=) # unsupported flags
            echo "Error: Unsupported flag $1" >&2
            help
            exit 1
            ;;
    esac
    done
}

# resolve_relative_links resolves any relative links passed as command line flags
# and turns them into absolute links
resolve_relative_links() {
    CATALOG_FILE_VOLUME=""
    MOUNTED_CATALOG_FILE=""
    if [ ! -z "${CATALOG_FILE}" ]; then
        CATALOG_FILE=$(readlink -f $CATALOG_FILE)
        CATALOG_FILE_VOLUME="-v ${CATALOG_FILE}:/usr/src/catalog/catalog-info.yml:ro"
        MOUNTED_CATALOG_FILE="/usr/src/catalog/catalog-info.yml"
    fi
    ENTITY_DIRECTORY=$(readlink -f $ENTITY_DIRECTORY)
}

# invoke_docker runs the docker image to build and display techdocs
invoke_docker() {
    docker run \
    --pull always \
    --platform linux/amd64 \
    -v ${ENTITY_DIRECTORY}:/usr/src/entity/:ro ${CATALOG_FILE_VOLUME} \
    --name techdocs-preview \
    -p ${PORT}:7007 \
    -e CATALOG_FILE=${MOUNTED_CATALOG_FILE} \
    -e VERBOSE=${VERBOSE} \
    -e HOST_PORT=${PORT} \
    --rm -it \
    ${IMAGE_NAME}:${IMAGE_TAG}
}

main() {
    parse_flags "$@"
    check_prerequisites
    resolve_relative_links
    invoke_docker
}

main "$@"
