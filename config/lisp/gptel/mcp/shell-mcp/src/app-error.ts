export class AppError extends Error {

  code: string;
  statusCode?: number;

  constructor(message: string, code: string, statusCode: number = 400, cause?: unknown) {
    super(message);
    this.code = code;
    this.statusCode = statusCode;
    this.cause = cause;
    this.name = this.constructor.name;
    Error.captureStackTrace(this, this.constructor);
  }
}
