#!/bin/bash
# Break on error
set -e
# Raise error if any command in the pipeline fails
set -o pipefail

function usage
{
        cat << END

Usage: `basename $0` [options]

Options:

	-d database_name		- specify the database from which you would like to export the schema

	-n name of output files		- the name of the output file

	-h 				- prints this message

Description:

	A simple tool used to export an Informix Database s schema
END
        exit
}

while getopts d:n:h o
do
        case $o in  d) database=$OPTARG;;
                    n) output=$OPTARG;;
                    h) help=1;;
        esac
done
shift `expr $OPTIND - 1`

if [ "$help" ]; then
        usage
fi

if [ -z "$output" ]; then
	now=$(date +"%d-%m-%Y")
	output=exported_schema-$now.sql
fi

if [ -z "$database" ]; then
	echo "You need to specify a database"
	exit 1
fi

dbschema -t all -f all -d $database $output

