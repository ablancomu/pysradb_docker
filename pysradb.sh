#!/bin/bash

# Receive a file with a list of SRA Samples IDs, one per row.
if [ "${INPUT}" == "NULL" ] && [ "${SRP}" != "NULL" ]; then
    pysradb metadata ${SRP} --detailed > ${SRP}.metadata
    pysradb download -y -t ${THREADS} -p ${SRP}
elif [ "${INPUT}" != "NULL" ] && [ "${SRP}" != "NULL" ]; then
    echo "Entro 1"
    if [[ -f "$INPUT" ]]; then
        echo "Entro 2"
        sed '1s/^/sample_accession\n/' ${INPUT} > tmp
        cat tmp
    else
        echo "{$INPUT} doesnt exist"
        exit
    fi
    pysradb metadata ${SRP} --detailed | grep -f tmp > ${SRP}_subset.metadata
    cat ${SRP}_subset.metadata | pysradb download -y -t ${THREADS}
else
    echo "ERROR: check the input file or study accesion ID (SRP)"
fi 

rm tmp
