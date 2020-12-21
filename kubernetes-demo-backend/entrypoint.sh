#!/bin/bash

export JAVA_OPTS="-Xmx${JAVA_MAX_MEM} $JVM_ENCODING_OPTS"

# Execute process
cd $DEMO_HOME
if [ ! -z ${SPRING_DEBUG+x} ]; then
  echo "Launching in debug mode"
  exec $JAVA_HOME/bin/java -Ddebug $JAVA_OPTS -jar $DEMO_HOME/kubernetes-demo-backend-0.1.0.jar >> /proc/self/fd/1 2>> /proc/self/fd/2
else
  exec $JAVA_HOME/bin/java $JAVA_OPTS -jar $DEMO_HOME/kubernetes-demo-backend-0.1.0.jar >> /proc/self/fd/1 2>> /proc/self/fd/2
fi