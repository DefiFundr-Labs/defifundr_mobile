import 'package:defifundr_mobile/core/widgets/fade_transition_page_router.dart';
import 'package:defifundr_mobile/feature/transaction_screen/screens/transactions.dart';
import 'package:go_router/go_router.dart';
import 'package:defifundr_mobile/feature/transaction_screen/widgets/transaction_detail_sheet.dart';
import 'package:defifundr_mobile/feature/transaction_screen/screens/transaction_detail_screen.dart';
import 'package:defifundr_mobile/feature/transaction_screen/models/transaction_model.dart';

class _TransactionPaths {
  final transactions = '/transactions';
  final transactionDetail = '/transaction-detail';
}

class TransactionRoutes {
  static final paths = _TransactionPaths();
  static final routes = [
    GoRoute(
      path: paths.transactions,
      name: paths.transactions,
      pageBuilder: (context, state) {
        return FadeTransitionPage(
            key: state.pageKey, child: const TransactionsScreen());
      },
    ),
    GoRoute(
      path: paths.transactionDetail,
      name: 'transactionDetail',
      pageBuilder: (context, state) {
        final transaction = state.extra as TransactionModel;
        return FadeTransitionPage(
          key: state.pageKey,
          child: TransactionDetailScreen(transaction: transaction),
        );
      },
    ),
  ];
}
