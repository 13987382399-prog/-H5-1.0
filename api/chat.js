const https = require('https');

module.exports = (req, res) => {
    // 设置 CORS 头，允许跨域访问
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');

    // 处理预检请求
    if (req.method === 'OPTIONS') {
        res.status(200).end();
        return;
    }

    if (req.method !== 'POST') {
        res.status(405).json({ error: 'Method Not Allowed' });
        return;
    }

    const DASHSCOPE_API_KEY = process.env.DASHSCOPE_API_KEY || 'sk-ccd54aa1ffaa47c39cfc529f0228b378';
    
    // 获取请求体 (Vercel 会自动解析 JSON body)
    const { message } = req.body || {};
    const userMessage = message || '';

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
            try {
                const parsedBody = JSON.parse(apiResponseBody);
                res.status(200).json(parsedBody);
            } catch (e) {
                res.status(500).json({ error: 'Invalid response from AI service', raw: apiResponseBody });
            }
        });
    });

    apiReq.on('error', (e) => {
        console.error(`Problem with request: ${e.message}`);
        res.status(500).json({ error: e.message });
    });

    apiReq.write(apiData);
    apiReq.end();
};
