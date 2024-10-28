dispatch_namespace := "outbound-poc"

init: deploy-namespace

deploy-all: deploy-outbound deploy-dispatcher deploy-user-premium deploy-user-free

delete-all: delete-outbound delete-dispatcher delete-namespace

deploy-namespace:
  npx wrangler dispatch-namespace create "{{dispatch_namespace}}"

delete-namespace:
  npx wrangler dispatch-namespace delete "{{dispatch_namespace}}"

deploy-dispatcher:
  #!/usr/bin/env bash
  npx pnpm -C ./outbound-poc-dispatcher/ install
  cd ./outbound-poc-dispatcher/
  npx wrangler deploy

delete-dispatcher:
  #!/usr/bin/env bash
  cd ./outbound-poc-dispatcher/
  npx wrangler delete --yes

deploy-outbound:
  #!/usr/bin/env bash
  npx pnpm -C ./outbound-poc-outbound/ install
  cd ./outbound-poc-outbound/
  npx wrangler deploy

delete-outbound:
  #!/usr/bin/env bash
  cd ./outbound-poc-outbound/
  npx wrangler delete

deploy-user-premium:
  #!/usr/bin/env bash
  npx pnpm -C ./outbound-poc-user-premium/ install
  cd ./outbound-poc-user-premium/
  npx wrangler deploy --dispatch-namespace "{{dispatch_namespace}}"

delete-user-premium:
  #!/usr/bin/env bash
  cd ./outbound-poc-user-premium/
  npx wrangler delete

deploy-user-free:
  #!/usr/bin/env bash
  npx pnpm -C ./outbound-poc-user-free/ install
  cd ./outbound-poc-user-free/
  npx wrangler deploy --dispatch-namespace "{{dispatch_namespace}}"
