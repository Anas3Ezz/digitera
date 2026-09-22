class ApiResult<T> {
  const ApiResult();
}



class Sucess<T> extends ApiResult{

final T data;

const Sucess(this.data);
}


class Error<T> extends ApiResult{

final T error;

const Error(this.error);
}