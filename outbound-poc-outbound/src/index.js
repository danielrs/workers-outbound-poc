export default {
	async fetch(request, env, ctx) {
		console.log(JSON.stringify(env));
		if (env.params.customerPlan == "premium") {
			return env.ORIGIN.fetch(request)
		} else {
			return fetch(request)
		}
	}
};
