# omar-database
## Setup
In order to set up the database for use, use the Dockerfile or the pre-built image in the O2 Docker Registry.

After spinning up the container, you must run one command in order to see data in the database.

**$ psql ./omardb.sql**

After doing this, all of the images from the **Standard_test_imagery_set** in s3://o2-test-data will be indexed. The user must make sure they are mounted in the expected location for OSSIM.
