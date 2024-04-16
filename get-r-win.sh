# Copyright (c) 2018 Dirk Schumacher, Noam Ross, Rich FitzJohn
# copyright (c) 2023 Jinhwan Kim
# Download and extract the Windows binary install
mkdir r-win

curl -o r-win/latest_r.exe https://cloud.r-project.org/bin/windows/base/old/4.3.2/R-4.3.2-win.exe

cd r-win
innoextract -e latest_r.exe
mv app/* ../r-win
rm -r app latest_r.exe 

# Remove unneccessary files 
rm -r doc tests 
