#!/bin/bash
package_name_int=$(echo "$package_name" | tr -d [:space:]);

filename_uat=$(ls /data/igprepo/uat/$package_name_int/$package_name_int* |sort -r  | head -n 1);
if [ $? == 0 ] && [ ! -z $filename_uat ];
then
    if [ ! -d "/data/igprepo/prod/$package_name_int" ];
    then
       mkdir -p /data/igprepo/prod/$package_name_int;
       sleep 5;
    fi;

    if [ -d "/data/igprepo/prod/$package_name_int" ];
    then
       echo "Moving $filename_uat to Production"
       sudo cp -vp $filename_uat /data/igprepo/prod/$package_name_int/;
       filename_prod=$(ls /data/igprepo/prod/$package_name_int/$package_name_int* |sort -r  | head -n 1);

       if [ "`basename $filename_prod`" == "`basename $filename_uat`" ]
       then
          sudo createrepo --update --cachedir=/data/igprepo/rpmcache/prod/rpmcache_$package_name_int --no-database --workers 4 /data/igprepo/prod/$package_name_int;
       else
          exit 1;
       fi;
    else
       exit 1;
    fi;
else
   exit 1;
fi;
