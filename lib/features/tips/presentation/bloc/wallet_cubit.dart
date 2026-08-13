import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/wallet.dart';
import '../../domain/repositories/tips_repository.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final TipsRepository tipsRepository;

  WalletCubit({required this.tipsRepository}) : super(const WalletInitial());

  Future<void> loadWallet() async {
    emit(const WalletLoading());
    final walletResult = await tipsRepository.getWallet();
    final txResult = await tipsRepository.getTransactions();

    walletResult.fold(
      (failure) => emit(WalletError(failure.message)),
      (wallet) {
        final transactions = txResult.fold((_) => <WalletTransaction>[], (t) => t);
        emit(WalletLoaded(wallet: wallet, transactions: transactions));
      },
    );
  }

  Future<void> refreshWallet() async {
    final walletResult = await tipsRepository.getWallet();
    final txResult = await tipsRepository.getTransactions();
    walletResult.fold(
      (_) {},
      (wallet) {
        final transactions = txResult.fold((_) => <WalletTransaction>[], (t) => t);
        emit(WalletLoaded(wallet: wallet, transactions: transactions));
      },
    );
  }
}
