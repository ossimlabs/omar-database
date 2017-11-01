# omar-database
## Setup
In order to set up the database for use, use the Dockerfile or the pre-built image in the O2 Docker Registry.

After spinning up the container, you must run two commands in order to see data in the database.

**$ su postgres**

**$ psql -d o2_omar_db -f /var/lib/pgsql/9.4/data/omardb.sql**

You must also set these three environment variables

**POSTGRES_DB=o2_omar_db**

**POSTGRES_USER=omardb**

**POSTGRES_PASSWORD=[password in application-database-test.yml]**

After doing this, all of the images from the **Standard_test_imagery_set** in s3://o2-test-data will be indexed. The user must make sure they are mounted in the expected location for OSSIM, usually **/data**.

## Setting the OMAR services to use the database
In order for the OMAR services to look for this database, the omarDb fields in the **application.yml** must be changed. An example of the correct config can be found in the config repo under **application-database-test.yml**. Only the items under omarDb are important for the database.

The images pre-staged are expected to be in the following locations:

/data/s3/2008/03/11/01/11MAR08WV010500008MAR11071429-P1BS-005707719010_04_P003.ntf
/data/s3/2011/12/04/05/04DEC11050020-M2AS_R1C1-000000185964_01_P001.TIF
/data/s3/2011/12/04/05/04DEC11050020-P2AS_R1C1-000000185964_01_P001.TIF
/data/s3/2010/12/05/22/2010-12-05T221358_RE2_3A-NAC_6683383_113276.tif
/data/s3/2015/09/14/01/14SEP15TS0107001_100021_SL0023L_25N121E_001X___SVV_0101_OBS_IMAG.ntf
/data/s3/2001/08/14/04/14SEP12113301-M1BS-053951940020_01_P001.TIF
/data/s3/2001/08/14/04/14AUG20010406-M1BS-053852449040_01_P001.TIF
/data/s3/2009/02/05/00/05FEB09OV05010005V090205M0001912264B220000100072M_001508507.ntf
/data/s3/2001/08/14/04/14AUG20010406-P1BS-053852449040_01_P001.TIF
/data/s3/2009/02/05/00/05FEB09OV05010005V090205P0001912264B220000100282M_001508507.ntf
/data/s3/2009/02/05/00/po_106005_pan_0000000.ntf
/data/s3/2016/05/02/00/16MAY02111606-P1BS-055998375010_01_P013.TIF
/data/s3/2016/05/02/00/16MAY02111607-P1BS-055998375010_01_P014.TIF
