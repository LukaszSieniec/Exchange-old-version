import 'package:exchange/blocs/wallet/wallet_event.dart';
import 'package:exchange/blocs/wallet/wallet_state.dart';
import 'package:exchange/database/account_balance.dart';
import 'package:exchange/models/cryptocurrency.dart';
import 'package:exchange/repositories/cryptocurrency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final CryptocurrencyRepository _cryptocurrencyRepository;

  WalletBloc(this._cryptocurrencyRepository) : super(WalletLoadInProgress()) {
    on<WalletLoaded>(_onWalletLoaded);
  }

  Future<void> _onWalletLoaded(
      WalletLoaded event, Emitter<WalletState> emit) async {
    try {
      final List<Cryptocurrency> cryptocurrencies =
          await _cryptocurrencyRepository.readAllCryptocurrencies();
      final double accountBalance = AccountBalance.readAccountBalance();

      emit(WalletLoadSuccess(accountBalance, cryptocurrencies));
    } on Exception {
      emit(WalletLoadFailure());
    }
  }
}
