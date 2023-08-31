// ignore: file_names
abstract class BaseViewModel extends BaseViewModelInputs
    implements BaseViewModelOutputs {
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
}

abstract class BaseViewModelOutputs {}
