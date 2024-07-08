#!/bin/bash

# Usage: ./bump-platform-version.sh RELEASE_VERSION MAVEN_LOCAL_REPO

RELEASE_VERSION=$1
MAVEN_LOCAL_REPO=$2

# Use '' after -i to make it work in CI(Linux) and on macOS locally
sed -i 's|<platform.version>.*</platform.version>|<platform.version>'"${RELEASE_VERSION}"'</platform.version>|g' pom.xml
mvn -Dmaven.repo.local=${MAVEN_LOCAL_REPO} $MAVEN_CLI_OPTS verify
