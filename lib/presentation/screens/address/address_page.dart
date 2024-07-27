import 'package:arrow_client/application/address/address_cubit.dart';
import 'package:arrow_client/core/mutable_object.dart';
import 'package:arrow_client/presentation/router/app_router.dart';
import 'package:arrow_client/presentation/screens/address/utils/utils.dart';
import 'package:arrow_client/presentation/widgets/space.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddressPage extends StatelessWidget {
  AddressPage({super.key});

  final mAddress = MutableObject("");

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressCubit, Option<String>>(
      listener: (context, state) {
        if (state.isSome()) {
          context.router.push(const StreamRoute());
        }
      },
      child: Scaffold(
          body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  mAddress.value = value;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Enter IP Address"),
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [IPAddressInputFormatter()],
              ),
              const VGap(gap: 20),
              ElevatedButton(
                onPressed: () {
                  context.read<AddressCubit>().setAddress(mAddress.value);
                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
