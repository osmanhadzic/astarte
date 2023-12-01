export CASSANDRA_DB_HOST="127.0.0.1"
export CASSANDRA_DB_PORT="9042"
export REALM="test"
export XML_FILE="../files/test.xml"

/app/bin/astarte_import eval "Mix.Tasks.Astarte.Import.run [\"$REALM\",\"$XML_FILE\"]"
