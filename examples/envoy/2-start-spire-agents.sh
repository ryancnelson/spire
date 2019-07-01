#!/bin/bash

set -e

bb=$(tput bold)
nn=$(tput sgr0)

# Bootstrap trust to the SPIRE server for each agent by copying over the
# trust bundle into each agent container. Alternatively, an upstream CA could
# be configured on the SPIRE server and each agent provided with the upstream
# trust bundle (see UpstreamCA under
# https://github.com/spiffe/spire/blob/master/doc/spire_server.md#plugin-types)
echo "${bb}Bootstrapping trust between SPIRE agents and SPIRE server...${nn}"
docker-compose exec -T spire-server bin/spire-server bundle show |
	docker-compose exec web sh -c "cat > conf/agent/bootstrap.crt" 2>/dev/null
docker-compose exec -T spire-server bin/spire-server bundle show |
	docker-compose exec echo sh -c "cat > conf/agent/bootstrap.crt" 2>/dev/null


echo "web bundle:"
docker-compose exec -T web ls -la conf/agent/bootstrap.crt

echo "echo bundle:"
docker-compose exec -T echo ls -la conf/agent/bootstrap.crt



# Start up the web server SPIRE agent.
echo "${bb}Starting web server SPIRE agent...${nn}"
docker-compose exec -d web bin/spire-agent run

# Start up the echo server SPIRE agent.
echo "${bb}Starting echo server SPIRE agent...${nn}"
docker-compose exec -d echo bin/spire-agent run
