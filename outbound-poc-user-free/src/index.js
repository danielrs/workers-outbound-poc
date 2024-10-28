export default {
	async fetch(request, env, ctx) {
		// NOTE: the fetch below should point to the same zone the dispatcher is at.
		return fetch("https://origin.drivas.xyz/foo")
	},
};
