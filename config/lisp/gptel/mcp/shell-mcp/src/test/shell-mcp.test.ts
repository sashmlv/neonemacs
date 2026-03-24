import assert from 'node:assert';
import { Client } from '@modelcontextprotocol/sdk/client/index.js';
import { ExecOutput } from '../exec-tool';
import { CallToolResult } from '@modelcontextprotocol/sdk/types.js';
import { StdioClientTransport } from '@modelcontextprotocol/sdk/client/stdio.js';
import {
  it,
  after,
  before,
  describe,
} from 'node:test';

describe('exec', async () => {

  let toolName = 'exec';
  let client: Client;
  let shellTool: (Awaited<ReturnType<typeof client.listTools>>)['tools'][number];

  before(async () => {
    const command = 'npm';
    const args = ['start'];
    client = new Client({name: 'client', version: '0.0.1'});
    const transport = new StdioClientTransport({command, args});
    await client.connect(transport);
    const listTools: Awaited<ReturnType<typeof client.listTools>> = await client.listTools();
    shellTool = listTools.tools.find(t => t.name === toolName)!;
  })

  after(async () => {
    await client.close();
  })

  it('date', async() => {
    try {
      const cmd = 'date';
      const args = ['+%Y'];
      const ctResult: Partial<CallToolResult> = await client.callTool({
        name: shellTool.name,
        arguments: { cmd, args },
      })
      const {structuredContent} = ctResult;
      const {result} = structuredContent as ExecOutput;
      assert.strictEqual(
        result?.startsWith(new Date().getFullYear().toString()),
        true,
      )
    } catch (err) {
      console.error(err);
    }
  })

  it('date bad param', async() => {
    try {
      const cmd = 'date';
      const args = ['bad_param'];
      const ctResult: Partial<CallToolResult> = await client.callTool({
        name: shellTool.name,
        arguments: { cmd, args },
      })
      const {structuredContent} = ctResult;
      const {result, error} = structuredContent as ExecOutput;
      assert.strictEqual(result, '');
      assert.strictEqual(error?.name, 'Error');
      assert.strictEqual(error?.message.includes('invalid date'), true);
      assert.strictEqual(error?.stack?.includes('invalid date'), true);
    } catch (err) {
      console.error(err);
    }
  })

  it('empty command', async() => {
    try {
      const cmd = '';
      const args: [] = [];
      const ctResult: Partial<CallToolResult> = await client.callTool({
        name: shellTool.name,
        arguments: { cmd, args },
      })
      const {content, isError, structuredContent} = ctResult;
      const errorText = (isError && content?.length === 1 && content[0].type === 'text') ? content[0].text : '';
      assert.strictEqual(isError, true);
      assert.strictEqual(errorText.includes('empty'), true);
      assert.strictEqual(structuredContent, undefined);
    } catch (err) {
      console.error(err);
    }
  })

  it('date bad args', async() => {
    try {
      const cmd = 'date';
      const args = [123];
      const ctResult: Partial<CallToolResult> = await client.callTool({
        name: shellTool.name,
        arguments: { cmd, args },
      })
      const {content, isError, structuredContent} = ctResult;
      const errorText = (isError && content?.length === 1 && content[0].type === 'text') ? content[0].text : '';
      assert.strictEqual(isError, true);
      assert.strictEqual(errorText.includes('-32602'), true);
      assert.strictEqual(structuredContent, undefined);
    } catch (err) {
      console.error(err);
    }
  })

  it('bad command', async() => {
    try {
      const cmd = 'yeah';
      const args = ['awesome', 'parameters'];
      const ctResult: Partial<CallToolResult> = await client.callTool({
        name: shellTool.name,
        arguments: { cmd, args },
      })
      const {structuredContent} = ctResult;
      const {result, error} = structuredContent as ExecOutput;
      assert.strictEqual(result, '');
      assert.strictEqual(error?.name, 'Error');
      assert.strictEqual(error?.message.includes('not found'), true);
      assert.strictEqual(error?.stack?.includes('not found'), true);
    } catch (err) {
      console.error(err);
    }
  })
})
