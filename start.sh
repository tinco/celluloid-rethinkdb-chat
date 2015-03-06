if hash bundle 2>/dev/null; then
    bundle
else
    echo "Could not find bundler, install with: gem install bundler"
    exit 1
fi

bundle exec passenger start &
PASSENGER_PID=$!

if hash rethinkdb 2>/dev/null; then
    rethinkdb &
    RETHINKDB_PID=$!
else
    kill $PASSENGER_PID
    echo "Could not find rethinkdb"
    exit 1
fi

wait $PASSENGER_PID
wait $RETHINKDB_PID
