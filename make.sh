#!/bin/bash

#Make our interpreter from scratch
cd src/ && make clean

cd ..

zip -r interpreter.zip group.txt src/ example/pr*.spl

