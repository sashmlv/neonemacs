export type Err = typeof err;
export type ErrCode = typeof err[keyof typeof err]['code'];

export const err = {
  NOT_VALID: {
    code: 'NOT_VALID',
    message: 'Not valid',
  },
}
