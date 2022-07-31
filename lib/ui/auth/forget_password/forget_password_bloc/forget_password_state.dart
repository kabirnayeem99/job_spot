class ForgetPasswordState {
  bool? isLoading = false;

  ForgetPasswordState({this.isLoading});

  ForgetPasswordState init() {
    return ForgetPasswordState(isLoading: true);
  }

  ForgetPasswordState clone() {
    return ForgetPasswordState();
  }
}
