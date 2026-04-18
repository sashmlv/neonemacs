import * as z from 'zod/v4';
import { mcpServer } from './server';
import { NotAllowed } from './error';
import { ALLOWED_COMMANDS } from './constant';
import {
  exec,
  ExecOptions,
} from 'node:child_process';

export type ExecOutput = z.infer<typeof execOutputSchema>;

const EXEC_OPTIONS: ExecOptions = {
  timeout: 5000,
  killSignal: 'SIGTERM',
}

const execOutputSchema = z.object({
  result: z.string().optional(),
  error: z.object({
    name: z.string(),
    message: z.string(),
    stack: z.string().optional(),
  }).optional(),
})

mcpServer.registerTool('exec', {
  title: 'Exec',
  description: `
    This tool executes commands in the shell.
    ### What needs to be taken into account:
    * Allowed commands are: ${ALLOWED_COMMANDS.join(', ')}
    * If you want to run a command that is not in the list, ask the user to do so
    * This tool returns the result of executing the shell command
    ### This tool can be used for:
    * Development process
    * Run the project
    * Api calls
    * Error debbuging
    * And some other actions`,
  inputSchema: {
    cmd: z.string(),
    args: z.array(z.string()),
  },
  outputSchema: execOutputSchema,
}, async ({ cmd, args }) => {
  return new Promise((res, rej) => {
    try {
      const command = [cmd, ...args].join(' ');
      exec(command, EXEC_OPTIONS, (err, stdout, stderr) => {
        if (!ALLOWED_COMMANDS.includes(cmd)) {
          return rej(new NotAllowed(cmd));
        }
        const error = (err || stderr) ? {
          name: err?.name || 'Error',
          message: err?.message || stderr,
          stack: err?.stack || '',
        } : undefined;
        const result = stdout;
        const output = JSON.stringify({ result, error });
        const structuredContent = { result, error };
        return res({
          content: [{ type: 'text', text: output }],
          structuredContent,
        })
      })
    } catch(err) {
      rej(err);
    }
  })
})
