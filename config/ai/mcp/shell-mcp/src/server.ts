import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';

export const mcpServer = new McpServer({
  name: 'shell-mcp',
  version: '0.0.1'
})

process.on('SIGINT', async () => {
  await mcpServer.close()
  process.exit(2);
})

process.on('SIGTERM', async () => {
  await mcpServer.close()
  process.exit(15);
})

process.on('beforeExit', async () => {
  await mcpServer.close()
  process.exit(0);
})

process.on('uncaughtException', async (err: Error) => {
  console.error(`Uncaught Exception: ${err.message}`);
  console.error(err);
  await mcpServer.close();
  process.exit(1);
})

process.on('unhandledRejection', async (err: Error, promise: Promise<any>) => {
  console.error(`Unhandled Rejection: ${promise}`);
  console.error(err);
  await mcpServer.close();
  process.exit(1);
})
