#!/bin/bash

set -e

VERSION=$(xmlstarlet sel -N "n=http://maven.apache.org/POM/4.0.0" -t -v "/n:project/n:version" pom.xml)

echo "Building archetype with version $VERSION..."

mvn archetype:create-from-project -Darchetype.properties=archetype.properties -Darchetype.keepParent=true \
-Darchetype.encoding=UTF-8

echo "Fixing archetype POM..."
GENERATED_ARTIFACT_DIR="target/generated-sources/archetype/"
cd $GENERATED_ARTIFACT_DIR
ARCHETYPE_POM=pom.xml

echo "    Remove description"
xmlstarlet ed -L -N "n=http://maven.apache.org/POM/4.0.0" -d "/n:project/n:description" $ARCHETYPE_POM

echo "    Adding properties element"
xmlstarlet ed -L -N "n=http://maven.apache.org/POM/4.0.0" -i "/n:project/n:build" -t elem -n properties -v "" $ARCHETYPE_POM
xmlstarlet ed -L -N "n=http://maven.apache.org/POM/4.0.0" -s "/n:project/n:properties" -t elem -n "project.build.sourceEncoding" -v "UTF-8" $ARCHETYPE_POM

echo "Fixing archetype resources POM..."
TEMPLATE_POM=src/main/resources/archetype-resources/pom.xml

echo "    Replacing package names"
sed -i s/poussecafe.mymodule/\$\{package\}/g $TEMPLATE_POM

echo "    Removing useless elements"
xmlstarlet ed -L -N "n=http://maven.apache.org/POM/4.0.0" -d "/n:project/n:scm" $TEMPLATE_POM

echo "Testing archetype..."
mvn integration-test

echo "Removing integration tests from archetype..."
rm -rf src/main/resources/archetype-resources/src/it/
rm -rf src/test/resources/projects
rm -rf target/classes/archetype-resources/src/it/
rm -rf target/test-classes/projects/
