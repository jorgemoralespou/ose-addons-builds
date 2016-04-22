oc new-project extended-builds

# Create image for the 2 addons
oc create -f ../addons/postgresql-addon-resources.json
oc create -f ../addons/mysql-addon-resources.json

# Build from the code that's in my machine
oc start-build postgresql-driver-addon --from-dir=.. --follow --loglevel=8
oc start-build mysql-driver-addon --from-dir=.. --follow --loglevel=8

# Build the wildfly extended s2i that will 
oc create -f ../s2i-wildfly-addons/s2i-wildfly-addons.json
oc start-build s2i-wildfly-addons --from-dir=.. --follow --loglevel=8

# Deploy an application that will use mysql addon
oc create -f example-wildfly-addons-mysql.json 
#oc env bc/example-wildfly-addons-mysql BUILD_LOGLEVEL=8
oc start-build example-wildfly-addons-mysql --follow

# Deploy an application that will use postgresql addon
oc create -f example-wildfly-addons-postgresql.json 
#oc env bc/example-wildfly-addons-postgresql BUILD_LOGLEVEL=8
oc start-build example-wildfly-addons-postgresql --follow
