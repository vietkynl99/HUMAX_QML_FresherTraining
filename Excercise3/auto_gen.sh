#!/bin/bash

FILENAME=saveFile.json
LIMIT=5000

#clear file
if [ -f $FILENAME ]; then
	rm -r $FILENAME
fi

echo -e "{\n\t\"listModel\": [" >> $FILENAME

#loop
for (( i=0; i <= $LIMIT; ++i ))
do
    age=`expr $RANDOM % 100`
    role=`expr $i % 4`
    str="\t\t{\n\t\t\t\"age\": $age,\n\t\t\t\"name\": \"Kynl\",\n\t\t\t\"role\": $role\n\t\t}"
    if [ $i -ne $LIMIT ]
    then
        str+=","
    fi
    echo -e $str >> $FILENAME
done



echo -e "\t]\n}" >> $FILENAME