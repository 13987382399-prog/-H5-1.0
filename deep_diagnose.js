const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');

const logFile = path.join(__dirname, 'deep_diag_result.txt');
const errorFile = path.join(__dirname, 'deep_diag_error.txt');

console.log('Starting Deep Diagnostic...');
fs.writeFileSync(logFile, 'Diagnostic started...\n');

const cmd = `ssh root@8.137.59.55 "echo '--- WHOAMI ---' && whoami && echo '--- PROCESSES ---' && ps aux | grep node && echo '--- PM2 LIST ---' && pm2 list && echo '--- PM2 DESCRIBE ---' && pm2 describe kunming-guide && echo '--- CWD CONTENT ---' && ls -la /var/www/kunming-guide && echo '--- PACKAGE.JSON ---' && cat /var/www/kunming-guide/package.json && echo '--- GIT REMOTE ---' && cd /var/www/kunming-guide && git remote -v && echo '--- GIT STATUS ---' && cd /var/www/kunming-guide && git status"`;

try {
    exec(cmd, { maxBuffer: 1024 * 1024 * 5 }, (error, stdout, stderr) => {
        const output = `STDOUT:\n${stdout}\n\nSTDERR:\n${stderr}\n\nERROR:\n${error ? error.message : 'None'}`;
        fs.appendFileSync(logFile, output);
        console.log('Done.');
    });
} catch (e) {
    fs.writeFileSync(errorFile, e.toString());
    console.log('Error executing command');
}
