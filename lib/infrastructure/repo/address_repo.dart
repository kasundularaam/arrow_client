import 'package:arrow_client/domain/address/i_address_repo.dart';
import 'package:arrow_client/infrastructure/services/predict_arrow_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAddressRepo)
class AddressRepo implements IAddressRepo {
  final PredictArrowService _predictArrowService;
  AddressRepo(this._predictArrowService);

  @override
  set address(String address) {
    _predictArrowService.ipAddress = address;
  }
}
