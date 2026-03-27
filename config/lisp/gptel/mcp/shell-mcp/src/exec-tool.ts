import * as z from 'zod/v4';
import { mcpServer } from './server';
import {
  exec,
  ExecOptions,
} from 'node:child_process';
import {
  NotAllowed,
  AllowedCommandsRequired,
} from './error';

export type ExecOutput = z.infer<typeof execOutputSchema>;

const ALLOWED_COMMANDS = process.env.ALLOWED_COMMANDS?.split(',').filter(c => c) || [];

if(!ALLOWED_COMMANDS.length) {
  throw new AllowedCommandsRequired();
}

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
  description: 'Shell command executor',
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
        if (ALLOWED_COMMANDS.includes(command)) {
          rej(new NotAllowed(command));
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
