import { AllowedCommandsRequired } from './error';

const cmdRgx = /^[a-z0-9_-]+$/i;
export const ALLOWED_COMMANDS = process.env.ALLOWED_COMMANDS?.split(',').filter(c => c && cmdRgx.test(c)) || [];

if(!ALLOWED_COMMANDS.length) {
  throw new AllowedCommandsRequired();
}
