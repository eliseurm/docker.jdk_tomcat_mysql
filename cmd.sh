#!/bin/bash

/etc/init.d/mysql start

${CATALINA_HOME}/bin/startup.sh run 

bash
