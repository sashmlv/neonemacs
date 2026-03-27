import * as z from 'zod/v4';
import { mcpServer } from './server';
import { ALLOWED_COMMANDS } from './constant';

const allowedCommandsOutputSchema = z.object({
  result: z.string().optional(),
})

mcpServer.registerTool('get-allowed-commands', {
  title: 'Get Allowed Commands',
  description: 'This command returns a list of allowed bash commands',
  outputSchema: allowedCommandsOutputSchema,
}, async () => {
  const result = ALLOWED_COMMANDS.join(', ');
  const output = JSON.stringify({ result });
  const structuredContent = { result };
  return {
    content: [{ type: 'text', text: output }],
    structuredContent,
  }
})
