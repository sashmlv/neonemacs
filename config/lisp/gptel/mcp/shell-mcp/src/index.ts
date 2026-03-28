import './allowed-commands-tool';
import './exec-tool';
import { mcpServer } from './server';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';

async function main() {
  const transport = new StdioServerTransport();
  await mcpServer.connect(transport);
  console.log('*** PLEASE BE CAREFUL THIS TOOL IS DANGEROUS WITHOUT USER CONTROL! ***');
  console.log('Shell-MCP server is running...');
}

main().catch(error => {
  console.error('Server error:', error);
  process.exit(1);
})
