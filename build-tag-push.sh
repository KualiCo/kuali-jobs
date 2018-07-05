#!/bin/bash

repo='667650582711.dkr.ecr.us-west-2.amazonaws.com/mkt-jobs'
build_id=$(date +%s)

function build() {
  docker build -t mkt-jobs .
}

function tag() {
  docker build -t "${repo}:latest" .
  docker build -t "${repo}:${build_id}" .
}

function push() {
  echo "Logging in to repository ${repo}"
  $(aws ecr get-login --no-include-email)
  docker push "${repo}:latest"
  docker push "${repo}:${build_id}"
}

build
tag
push
