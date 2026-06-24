console.log("Starting boilerplate app...");
console.log("PROJECT_ENV: " + process.env.PROJECT_ENV + " | NODE_ENV: " + process.env.NODE_ENV);
console.log("ARGS: ", process.argv);
setInterval(() => {
	console.log("(Boilerplate) Node app is still running! Waiting 10 seconds...");
}, 10000);