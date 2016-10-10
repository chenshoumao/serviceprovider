#!/bin/sh

#/******************************************************************************
# *
# * Licensed Materials - Property of IBM
# *
# * Source File Name = build.sh
# *
# * (C) COPYRIGHT IBM Corp. 1999, 2009 All Rights Reserved
# *
# * US Government Users Restricted Rights - Use, duplication or
# * disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
# *
# *****************************************************************************/


JAVA_HOME=/opt/IBM/WebSphere/AppServer/java
ITIM_HOME=/opt/IBM/isim
APP_SERVER_DEPLOY_DIR=/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/installedApp/localhostNode01Cell/ITIM.ear
HTML_ROOT=/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/installedApp/localhostNode01Cell/ITIM.ear/app_web.war
JDBC_DRIVER_JAR=/opt/IBM/isim/lib//db2jcc.jar:/opt/IBM/isim/lib//db2jcc_license_cu.jar:/opt/IBM/isim/lib//db2jcc_license_cisuz.jar:/db2java.zip:$ITIM_HOME/lib/ojdbc.jar
ANT_HOME_LIB=REPLACE WITH ACTUAL VALUE OF ANT INSTALLATION DIRECTORY/LIB

COMPILER=modern
EJBCCOMPILER=javac
DEBUG=on
OPTIMIZE=off
DEPRECATION=on
VERBOSE=off
FAILONERROR=yes
ANT_OPTS="-ms256m -mx512m"

$JAVA_HOME/bin/java $ANT_OPTS -classpath $ANT_HOME_LIB/ant.jar:$ANT_HOME_LIB/ant-launcher.jar:$JAVA_HOME/lib/tools.jar:$JDBC_DRIVER_JAR:. org.apache.tools.ant.Main -Ditim.home=$ITIM_HOME -Dapp.deploy=$APP_SERVER_DEPLOY_DIR -Dhtml.root=$HTML_ROOT $1 $2 $3 $4 $5 $6 $7 $8 $9
