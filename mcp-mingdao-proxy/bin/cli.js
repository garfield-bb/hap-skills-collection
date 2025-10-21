#!/usr/bin/env node
import { spawn } from 'node:child_process';
import { createRequire } from 'node:module';
const require = createRequire(import.meta.url);

// 必填：远端 MCP 的 Streamable HTTP 端点
const { URI, MCP_NAME, BEARER_TOKEN } = process.env;
if (!URI) {
  console.error(
    'Missing URI.\n' +
    'Usage:\n' +
    '  URI="https://api2.mingdao.com/mcp?HAP-Appkey=***&HAP-Sign=***" npx @your-scope/mcp-mingdao-proxy\n'
  );
  process.exit(1);
}

// 可选：给服务一个易读名字（宿主里显示）
process.env.MCP_NAME = MCP_NAME || 'mingdao-streamable-mcp';

// 可选：若你的服务支持 Bearer 鉴权，放到环境变量里由适配器带上
if (BEARER_TOKEN) process.env.BEARER_TOKEN = BEARER_TOKEN;

// 适配器可执行入口（把本地 STDIO ↔ 远端 Streamable HTTP 连接起来）
const adapter = require.resolve('@pyroprompts/mcp-stdio-to-streamable-http-adapter/build/index.js');

// 以当前 Node 进程拉起适配器
const child = spawn(process.execPath, [adapter], {
  stdio: 'inherit',
  env: process.env,
});

child.on('exit', (code, signal) => {
  if (signal) {
    console.error(`Adapter exited due to signal: ${signal}`);
    process.exit(1);
  }
  process.exit(code ?? 0);
});
