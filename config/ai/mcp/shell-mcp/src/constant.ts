import { isAbsolute } from 'node:path';
import {
  CWDRequired,
  AllowedCommandsRequired,
} from './error';

const cmdRgx = /^[a-z0-9_-]+$/i;
export const ALLOWED_COMMANDS = process.env.ALLOWED_COMMANDS?.split(',').filter(c => c && cmdRgx.test(c)) || [];
export const CWD = process.env.CWD && isAbsolute(process.env.CWD) ? process.env.CWD : '';

if(!ALLOWED_COMMANDS?.length) {
  throw new AllowedCommandsRequired();
}

if(!CWD?.length) {
  throw new CWDRequired();
}
