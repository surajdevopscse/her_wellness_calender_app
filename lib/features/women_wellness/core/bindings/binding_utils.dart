import 'package:get/get.dart';

void ensureLazyPut<S>(
  InstanceBuilderCallback<S> builder, {
  bool fenix = true,
}) {
  if (!Get.isRegistered<S>()) {
    Get.lazyPut<S>(builder, fenix: fenix);
  }
}
