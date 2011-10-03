#!/bin/bash
CURRENT_FOLDER="$( cd "$( dirname "$0" )" && pwd )"

cd $CURRENT_FOLDER
rake monitor
