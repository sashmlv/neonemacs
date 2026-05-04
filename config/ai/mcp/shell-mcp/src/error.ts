import {AppError} from './app-error';

export class NotAllowed extends AppError {
  public static code = 'NOT_ALLOWED';
  public static statusCode = 450;
  public static message = 'Not allowed';
  constructor(issue: string, cause?: unknown) {
    super(
      `${NotAllowed.message}: ${issue}`,
      NotAllowed.code,
      NotAllowed.statusCode,
      cause,
    )
  }
}

export class AllowedCommandsRequired extends AppError {
  public static code = 'ALLOWED_COMMANDS_REQUIRED';
  public static statusCode = 400;
  public static message = 'Allowed commands required';
  constructor() {
    super(
      AllowedCommandsRequired.message,
      AllowedCommandsRequired.code,
      AllowedCommandsRequired.statusCode,
    )
  }
}

export class CWDRequired extends AppError {
  public static code = 'CWD_REQUIRED';
  public static statusCode = 400;
  public static message = 'CWD required';
  constructor() {
    super(
      CWDRequired.message,
      CWDRequired.code,
      CWDRequired.statusCode,
    )
  }
}
