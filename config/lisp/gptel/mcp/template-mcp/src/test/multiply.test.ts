import assert from 'node:assert';
import { Client } from '@modelcontextprotocol/sdk/client/index.js';
import { StdioClientTransport } from '@modelcontextprotocol/sdk/client/stdio.js';
import {
  it,
  after,
  before,
  describe,
} from 'node:test';

describe('multiply', async () => {

  let toolName = 'multiply';
  let client: Client;
  let multiplyTool: (Awaited<ReturnType<typeof client.listTools>>)['tools'][number];

  before(async () => {
    const command = 'npm';
    const args = ['start'];
    client = new Client({name: 'client', version: '0.0.1'});
    const transport = new StdioClientTransport({command, args});
    await client.connect(transport);
    const listTools: Awaited<ReturnType<typeof client.listTools>> = await client.listTools();
    multiplyTool = listTools.tools.find(t => t.name === toolName)!;
  })
  after(async () => {
    await client.close();
  })

  it('test', async() => {
    try {
      const a = 2;
      const b = 12
      const content = <{structuredContent: {result: number}}><unknown>await client.callTool({
        name: multiplyTool.name,
        arguments: { a, b },
      })
      const result = content.structuredContent?.result;
      assert.strictEqual(result, a * b);
    } catch (err) {
      console.error(err);
    }
  })
})
