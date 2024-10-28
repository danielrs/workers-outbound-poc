export default {
	async fetch(request, env) {
		try {
			let workerName = new URL(request.url).pathname.substring(1); // ignore trailing slash.
			switch (workerName) {
				case "outbound-poc-user-premium": {
					let userWorker = env.DISPATCHER.get(
						workerName,
						{},
						{
							outbound: {
								params: {
									customerPlan: "premium",
								},
							},
						},
					);
					return await userWorker.fetch(request);
					break;
				}
				case "outbound-poc-user-free": {
					let userWorker = env.DISPATCHER.get(
						workerName,
						{},
						{
							outbound: {
								params: {
									customerPlan: "free",
								},
							},
						},
					);
					return await userWorker.fetch(request);
					break;
				}
				default: {
					return new Response(`Worker not found: ${workerName}`, { status: 404 });
				}
			}
		} catch (e) {
			return new Response(e.message, { status: 500 });
		}
	}
}
