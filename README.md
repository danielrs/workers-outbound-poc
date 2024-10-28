
Proof-of-concept for using the `global_fetch_strictly_public` flag in [Outbound Workers](https://developers.cloudflare.com/cloudflare-for-platforms/workers-for-platforms/configuration/outbound-workers/).

The request flow is:

```
Eyeball -> Dispatcher -> Outbound -> User-worker (fetches from same zone the dispatcher is in)
```

## Requirements

- [Just](https://github.com/casey/just)
- [Node.js](https://nodejs.org/en/download/package-manager)

## Steps to set up

### 1. Zone configuration

We're gonna be using the zone `drivas.xyz` configured as follows:

- Origin Worker on `origin.drivas.xyz/foo` - Always returns `origin FOO`.

- Middleware Worker on `origin.drivas.xyz/foo` - Just wraps the request to the origin.

- AAAA route on `outbound-poc-dispatcher.drivas.xyz` - Make sure our dispatcher is reachable, content is `100::`.

### 2. Make necessary edits

If you're using a different zone, it might be necessary to edit the following files:

- `outbound-poc-dispatcher/src/wrangler.toml` - Route to your own zone.
- `outbound-poc-user-free/src/index.js` - Fetch from your own zone.
- `outbound-poc-user-premium/src/index.js` - Fetch from your own zone.

### 3. Deploy

First time:

```
just -v init
```

After that:

```
just -v deploy-all
```

### 4. Visit dispatcher

Free user should behave as any other eyeball request:

https://outbound-poc-dispatcher.drivas.xyz/outbound-poc-user-free

Premium user goes directly to the origin:

https://outbound-poc-dispatcher.drivas.xyz/outbound-poc-user-premium

