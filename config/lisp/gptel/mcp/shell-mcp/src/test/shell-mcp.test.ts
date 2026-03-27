import assert from 'node:assert';
import { Client } from '@modelcontextprotocol/sdk/client/index.js';
import { promisify } from 'node:util';
import { ExecOutput } from '../exec-tool';
import { CallToolResult } from '@modelcontextprotocol/sdk/types.js';
import { exec as exec_ } from 'node:child_process';
import { StdioClientTransport } from '@modelcontextprotocol/sdk/client/stdio.js';
import { AllowedCommandsRequired } from '../error';
import {
  it,
  after,
  before,
  describe,
} from 'node:test';

const exec = promisify(exec_);

describe('exec', async () => {

  let execToolName = 'exec';
  let getAllowedCommandsToolName = 'get-allowed-commands';
  let client: Client;
  let shellTool: (Awaited<ReturnType<typeof client.listTools>>)['tools'][number];
  let getAllowedCommandsTool: (Awaited<ReturnType<typeof client.listTools>>)['tools'][number];

  before(async () => {
    const command = 'npm';
    const args = ['start'];
    const env = {ALLOWED_COMMANDS: 'date,time%'};
    client = new Client({name: 'client', version: '0.0.1'});
    const transport = new StdioClientTransport({command, args, env});
    await client.connect(transport);
    const listTools: Awaited<ReturnType<typeof client.listTools>> = await client.listTools();
    shellTool = listTools.tools.find(t => t.name === execToolName)!;
    getAllowedCommandsTool = listTools.tools.find(t => t.name === getAllowedCommandsToolName)!;
  })

  after(async () => {
    await client.close();
  })

  it('check allowed commands required', async() => {
    try {
      await exec('npm start', {timeout: 5000, killSignal: 'SIGTERM'});
    } catch (err: any) {
      assert.strictEqual(err?.message.includes(AllowedCommandsRequired.code), true);
    }
  })

  it('check allowed commands list', async() => {
    try {
      const ctResult: Partial<CallToolResult> = await client.callTool({
        name: getAllowedCommandsTool.name,
        arguments: {},
      })
      const {structuredContent} = ctResult;
      const {result} = structuredContent as ExecOutput;
      assert.strictEqual(result, 'date');
    } catch (err) {
      console.error(err);
      throw err;
    }
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
      throw err;
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
      throw err;
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
      throw err;
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
      throw err;
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
      const {content, isError, structuredContent} = ctResult;
      const errorText = (isError && content?.length === 1 && content[0].type === 'text') ? content[0].text : '';
      assert.strictEqual(isError, true);
      assert.strictEqual(errorText.includes('Not allowed: ' + cmd), true);
      assert.strictEqual(structuredContent, undefined);
    } catch (err) {
      console.error(err);
      throw err;
    }
  })
})
