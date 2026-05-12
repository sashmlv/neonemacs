import { isAbsolute } from 'node:path';
import {
  CWDRequired,
  AllowedCommandsRequired,
} from './error';

const cmdRgx = /^[a-z0-9_-]+$/i;
const numRgx = /^\d+$/;
export const ALLOWED_COMMANDS = process.env.ALLOWED_COMMANDS?.split(',').filter(c => c && cmdRgx.test(c)) || [];
export const CWD = process.env.CWD && isAbsolute(process.env.CWD) ? process.env.CWD : '';
export const TIMEOUT = process.env.TIMEOUT && numRgx.test(process.env.TIMEOUT) ? Number(process.env.TIMEOUT) : null;

if(!ALLOWED_COMMANDS?.length) {
  throw new AllowedCommandsRequired();
}

if(!CWD?.length) {
  throw new CWDRequired();
}
