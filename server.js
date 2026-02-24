const http = require('http');
const https = require('https');
const fs = require('fs');
const path = require('path');

const PORT = 8084;
const DASHSCOPE_API_KEY = 'sk-ccd54aa1ffaa47c39cfc529f0228b378';

const server = http.createServer((req, res) => {
    // 处理 API 请求
    if (req.url === '/api/chat' && req.method === 'POST') {
        let body = '';
        req.on('data', chunk => {
            body += chunk.toString();
        });
        
        req.on('end', () => {
            try {
                const requestData = JSON.parse(body);
                const userMessage = requestData.message || '';
                
                // 构造调用千问 API 的数据
                const apiData = JSON.stringify({
                    model: 'qwen-turbo',
                    input: {
                        messages: [
                            { role: 'system', content: '你是一个专业的昆明老街文旅伴游助手，名字叫"海鸥伴游"。你的性格活泼开朗，非常熟悉昆明的历史文化、美食特色和景点故事。请用简洁、亲切的口吻回答游客的问题，多推荐周边的特色体验。' },
                            { role: 'user', content: userMessage }
                        ]
                    },
                    parameters: {
                        result_format: 'message'
                    }
                });

                const apiOptions = {
                    hostname: 'dashscope.aliyuncs.com',
                    path: '/api/v1/services/aigc/text-generation/generation',
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${DASHSCOPE_API_KEY}`
                    }
                };

                const apiReq = https.request(apiOptions, (apiRes) => {
                    let apiResponseBody = '';
                    
                    apiRes.on('data', (chunk) => {
                        apiResponseBody += chunk;
                    });
                    
                    apiRes.on('end', () => {
                        res.writeHead(200, { 'Content-Type': 'application/json' });
                        res.end(apiResponseBody);
                    });
                });

                apiReq.on('error', (e) => {
                    console.error(`Problem with request: ${e.message}`);
                    res.writeHead(500, { 'Content-Type': 'application/json' });
                    res.end(JSON.stringify({ error: e.message }));
                });

                apiReq.write(apiData);
                apiReq.end();
                
            } catch (error) {
                res.writeHead(400, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({ error: 'Invalid JSON' }));
            }
        });
        return;
    }

    // 处理静态文件请求
    console.log(`Request for ${req.url}`);
    
    let filePath = '.' + req.url;
    if (filePath === './') {
        filePath = './index.html';
    }

    const extname = String(path.extname(filePath)).toLowerCase();
    const mimeTypes = {
        '.html': 'text/html',
        '.js': 'text/javascript',
        '.css': 'text/css',
        '.json': 'application/json',
        '.png': 'image/png',
        '.jpg': 'image/jpg',
        '.gif': 'image/gif',
        '.svg': 'image/svg+xml',
    };

    const contentType = mimeTypes[extname] || 'application/octet-stream';

    fs.readFile(filePath, (error, content) => {
        if (error) {
            if(error.code == 'ENOENT'){
                res.writeHead(404);
                res.end('404 Not Found');
            } else {
                res.writeHead(500);
                res.end('Error: ' + error.code + ' ..\n');
            }
        } else {
            res.writeHead(200, { 'Content-Type': contentType });
            res.end(content, 'utf-8');
        }
    });
});

server.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}/`);
});
