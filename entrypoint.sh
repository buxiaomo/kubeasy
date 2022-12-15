#!/bin/sh
make help
echo "\033[32m-> You are running in a container and you can skip the \`make runtime\`\033[0m"
echo "\033[32m-> Next, run \`make hosts\` to create asset information, and then run \`make deploy REGISTRY_URL=https://example.com\` to deploy kubernetes\033[0m"
exec "$@"