const { exec } = require('child_process');
const fs = require('fs');

// Using a very simple command first to test connectivity and file writing
// If this works, we know we can run commands.
const cmd = `ssh root@8.137.59.55 "echo '--- WHOAMI ---'; whoami; echo '--- FILE VERSION ---'; cat /var/www/kunming-guide/package.json | grep version; echo '--- GIT LOG ---'; cd /var/www/kunming-guide && git log -1 --oneline; echo '--- PM2 LIST ---'; pm2 list; echo '--- PROCESSES ---'; ps aux | grep 'node'"`;

try {
    exec(cmd, (error, stdout, stderr) => {
        const output = `STDOUT:\n${stdout}\n\nSTDERR:\n${stderr}\n\nERROR:\n${error ? error.message : 'None'}`;
        fs.writeFileSync('server_diag_node.txt', output);
    });
} catch (e) {
    fs.writeFileSync('server_diag_error.txt', e.toString());
}
