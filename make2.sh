#!/bin/bash

rm solutionsAndManual.zip

zip -r solutionsAndManual.zip ./group.txt ./StreASMDocumentation.pdf

cd example && zip -r ../solutionsAndManual.zip ./pr{6,7,8,9,10}.spl
