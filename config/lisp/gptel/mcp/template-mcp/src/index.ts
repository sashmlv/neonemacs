import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js';
import * as z from 'zod/v4';

const mcpServer = new McpServer({
  name: 'template-mcp',
  version: '0.0.1'
})

mcpServer.registerTool(
  'multiply',
  {
    title: 'Multiplicator',
    description: 'Multiply 2 numbers',
    inputSchema: {
      a: z.number(),
      b: z.number(),
    },
    outputSchema: { result: z.number() }
  },
  async ({ a, b }) => {
    const output = { result: a * b };
    return {
      content: [{ type: 'text', text: JSON.stringify(output) }],
      structuredContent: output,
    }
  }
)

async function main() {
  const transport = new StdioServerTransport();
  await mcpServer.connect(transport);
  console.log('Template MCP server is running...');
}

main().catch(error => {
  console.error('Server error:', error);
  process.exit(1);
})
