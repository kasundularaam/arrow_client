// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:arrow_client/domain/address/i_address_repo.dart';

@injectable
class AddressCubit extends Cubit<Option<String>> {
  final IAddressRepo _addressRepo;
  AddressCubit(
    this._addressRepo,
  ) : super(const None());

  void setAddress(String address) {
    _addressRepo.address = address;
    emit(some(address));
  }
}
