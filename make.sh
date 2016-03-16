#!/bin/bash

rm interpreter.zip

#Make our interpreter from scratch
cd src/ && make clean && zip -r ../interpreter.zip .

cd ../example && zip -r ../interpreter.zip ./pr*.spl

cd ../ && zip -r interpreter.zip ./group.txt
