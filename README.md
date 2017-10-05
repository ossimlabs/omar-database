# omar-database
## Setup
In order to set up the database for use, use the Dockerfile or the pre-built image in the O2 Docker Registry.

After spinning up the container, you must run one command in order to see data in the database.

**$ su postgres**
**$ psql -f /var/lib/pgsql/9.4/data/omardb.sql**

After doing this, all of the images from the **Standard_test_imagery_set** in s3://o2-test-data will be indexed. The user must make sure they are mounted in the expected location for OSSIM, usually **/data**.

## Setting the OMAR services to use the database
In order for the OMAR services to look for this database, the omarDb fields in the **application.yml** must be changed. An example of the correct config can be found in the config repo under **application-database-test.yml**. Only the items under omarDb are important for the database.
