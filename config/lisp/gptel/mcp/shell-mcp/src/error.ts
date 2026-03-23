import {err} from './err';
import {AppError} from './app-error';

export class NotValidError extends AppError {
  constructor(message = err.NOT_VALID.message, code = err.NOT_VALID.code, cause?: unknown) {
    super(message, code, 400, cause)
  }
}
