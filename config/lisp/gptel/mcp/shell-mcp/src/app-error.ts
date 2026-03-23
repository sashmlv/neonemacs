import {
  err,
  ErrCode
} from './err';

export class AppError extends Error {

  code: ErrCode;
  statusCode?: number;

  constructor(message: string, code: ErrCode, statusCode: number = 400, cause: unknown) {
    super(message);
    this.code = code;
    this.statusCode = statusCode;
    this.cause = cause;
    this.name = this.constructor.name;
    Error.captureStackTrace(this, this.constructor);
  }
}

export class NotValidError extends AppError {
  constructor(message = err.NOT_VALID.message, code = err.NOT_VALID.code, cause: unknown) {
    super(message, code, 400, cause);
  }
}
