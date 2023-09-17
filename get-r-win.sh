# Copyright (c) 2018 Dirk Schumacher, Noam Ross, Rich FitzJohn
# 2023 Jinhwan Kim
# Download and extract the Windows binary install
mkdir r-win
wget https://cloud.r-project.org/bin/windows/base/R-4.3.1-win.exe \
--output-document r-win/latest_r.exe
cd r-win
innoextract -e latest_r.exe
mv app/* ../r-win
rm -r app latest_r.exe 

# Remove unneccessary files 
rm -r doc tests 
