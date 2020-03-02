#!/bin/bash

find . -type f -name "*.Rmd" -print0 | xargs -0 sed -i '' -e 's/CO2/CO~2~/g'
find . -type f -name "*.Rmd" -print0 | xargs -0 sed -i '' -e 's/CH4/CH~4~/g'
find . -type f -name "*.Rmd" -print0 | xargs -0 sed -i '' -e 's/N2O/N~2~O/g'
find . -type f -name "*.Rmd" -print0 | xargs -0 sed -i '' -e 's/PM10/PM~10~/g'
find . -type f -name "*.Rmd" -print0 | xargs -0 sed -i '' -e 's/PM2.5/PM~2.5~/g'
find . -type f -name "*.Rmd" -print0 | xargs -0 sed -i '' -e 's/SO2/SO~2~/g'
find . -type f -name "*.Rmd" -print0 | xargs -0 sed -i '' -e 's/SOx/SO~x~/g'
find . -type f -name "*.Rmd" -print0 | xargs -0 sed -i '' -e 's/NOx/NO~x~/g'
find . -type f -name "*.Rmd" -print0 | xargs -0 sed -i '' -e 's/NH3/NH~3~/g'
find . -type f -name "*.Rmd" -print0 | xargs -0 sed -i '' -e 's/H2S/H~2~S/g'
