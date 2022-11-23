const cmd = (process.argv[2] + '').replace(/{{(.*?)}}/g, (n, t) => {
    if(typeof process.env[t] !== "undefined"){
        return process.env[t];
    }
    return n;
});
console.log('RUNNING: ' + cmd);
return require('child_process').execSync(cmd, {
    cwd: process.cwd(),
    stdio: "inherit"
});