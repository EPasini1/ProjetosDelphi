set ISC_USER=sysdba
set ISC_PASSWORD=masterkey
"25/gfix" -rollback all LUMAROLD.fdb
"25/gfix" -shut -force 0 LUMAROLD.fdb
"25/gfix" -s LUMAROLD.fdb
"25/gfix" -v -f LUMAROLD.fdb
"25/gfix" -m -i LUMAROLD.fdb
"25/gbak" -g -b -z -l -v LUMAROLD.fdb
"25/gbak" -g -b -z -l -v LUMAROLD.fdb bd25.gbk
"30/gbak" -c -z -v db25.gbk D:\mig_firebird\LUMAR
"40/gfix" -online D:\mig_firebird\LUMAR
