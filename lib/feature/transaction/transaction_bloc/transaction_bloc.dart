import 'package:defifundr_mobile/feature/transaction/models/transaction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class LoadTransactions extends TransactionEvent {}

class FilterTransactions extends TransactionEvent {
  final List<String> types;
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;
  final String search;

  const FilterTransactions({
    required this.types,
    required this.status,
    this.startDate,
    this.endDate,
    this.search = '',
  });

  @override
  List<Object> get props => [
        types,
        status,
        startDate ?? '',
        endDate ?? '',
        search,
      ];
}

// States
abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final Map<DateTime, List<TransactionModel>> transactionsByDate;

  const TransactionLoaded(this.transactionsByDate);

  @override
  List<Object> get props => [transactionsByDate];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<FilterTransactions>(_onFilterTransactions);
  }

  void _onLoadTransactions(
      LoadTransactions event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    try {
      // Mock data
      final mockTransactions = [
        TransactionModel(
          type: TransactionType.withdrawal,
          title: 'Withdrawal',
          amount: '-588',
          currency: 'USDT',
          timestamp: DateTime.now(),
          status: TransactionStatus.processing,
          network: 'Ethereum',
          fromAddress: '0×6885afa...6f23b3',
          transactionId: '0×6885afa...63b3',
          date: DateTime.now(),
          withdrawalAddress: '0×6885afa...6f23b3',
          withdrawalMethod: 'Bank Transfer',
        ),
        TransactionModel(
          type: TransactionType.contract,
          title: 'Contract Payment',
          amount: '+1200',
          currency: 'USDT',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          status: TransactionStatus.successful,
          network: 'Ethereum',
          fromAddress: '0×6885afa...6f23b3',
          transactionId: '0×6885afa...63b3',
          date: DateTime.now().subtract(const Duration(hours: 2)),
          contractName: 'MintForge Bug fixes and UI improvements',
          contractType: 'Fixed Rate',
          invoiceNumber: '#INV-2025-001',
          client: 'Adegboyega Oluwagbemiro',
          timeline: [
            TimelineStep(
              title: 'Contract created',
              time: DateTime.now().subtract(const Duration(hours: 3)),
              completed: true,
            ),
            TimelineStep(
              title: 'Payment initiated',
              time: DateTime.now()
                  .subtract(const Duration(hours: 2, minutes: 30)),
              completed: true,
            ),
            TimelineStep(
              title: 'Payment completed',
              time: DateTime.now().subtract(const Duration(hours: 2)),
              completed: true,
            ),
          ],
        ),
        TransactionModel(
          type: TransactionType.invoice,
          title: 'Invoice #123',
          amount: '+500',
          currency: 'USDT',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          status: TransactionStatus.successful,
          network: 'Ethereum',
          fromAddress: '0×6885afa...6f23b3',
          transactionId: '0×6885afa...63b3',
          date: DateTime.now().subtract(const Duration(days: 1)),
          billedTo: 'Ore Hassan',
          invoiceId: '#INV-2025-002',
          timeline: [
            TimelineStep(
              title: 'Invoice created',
              time: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
              completed: true,
            ),
            TimelineStep(
              title: 'Payment initiated',
              time:
                  DateTime.now().subtract(const Duration(days: 1, minutes: 30)),
              completed: true,
            ),
            TimelineStep(
              title: 'Payment processed',
              time:
                  DateTime.now().subtract(const Duration(days: 1, minutes: 15)),
              completed: true,
            ),
            TimelineStep(
              title: 'Funds received in your account',
              time: DateTime.now().subtract(const Duration(days: 1)),
              completed: true,
            ),
          ],
        ),
        TransactionModel(
          type: TransactionType.quickpay,
          title: 'QuickPay Transfer',
          amount: '-200',
          currency: 'USDT',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          status: TransactionStatus.failed,
          network: 'Ethereum',
          fromAddress: '0×6885afa...6f23b3',
          transactionId: '0×6885afa...63b3',
          date: DateTime.now().subtract(const Duration(days: 1)),
          recipient: 'John Doe',
          paymentMethod: 'Bank Transfer',
        ),
      ];

      // Group transactions by date
      final transactionsByDate = <DateTime, List<TransactionModel>>{};
      for (var transaction in mockTransactions) {
        final date = DateTime(
          transaction.timestamp.year,
          transaction.timestamp.month,
          transaction.timestamp.day,
        );
        transactionsByDate.putIfAbsent(date, () => []).add(transaction);
      }

      // Sort dates in descending order
      final sortedDates = transactionsByDate.keys.toList()
        ..sort((a, b) => b.compareTo(a));

      // Create a new map with sorted dates
      final sortedTransactionsByDate = Map.fromEntries(
        sortedDates.map((date) => MapEntry(date, transactionsByDate[date]!)),
      );

      emit(TransactionLoaded(sortedTransactionsByDate));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }

  void _onFilterTransactions(
    FilterTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    emit(TransactionLoading());
    try {
      // Mock data (same as in _onLoadTransactions)
      final mockTransactions = [
        TransactionModel(
          type: TransactionType.withdrawal,
          title: 'Withdrawal',
          amount: '-588',
          currency: 'USDT',
          timestamp: DateTime.now(),
          status: TransactionStatus.processing,
          network: 'Ethereum',
          fromAddress: '0×6885afa...6f23b3',
          transactionId: '0×6885afa...63b3',
          date: DateTime.now(),
          withdrawalAddress: '0×6885afa...6f23b3',
          withdrawalMethod: 'Bank Transfer',
        ),
        TransactionModel(
          type: TransactionType.contract,
          title: 'Contract Payment',
          amount: '+1200',
          currency: 'USDT',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          status: TransactionStatus.successful,
          network: 'Ethereum',
          fromAddress: '0×6885afa...6f23b3',
          transactionId: '0×6885afa...63b3',
          date: DateTime.now().subtract(const Duration(hours: 2)),
          contractName: 'MintForge Bug fixes and UI improvements',
          contractType: 'Fixed Rate',
          invoiceNumber: '#INV-2025-001',
          client: 'Adegboyega Oluwagbemiro',
          timeline: [
            TimelineStep(
              title: 'Contract created',
              time: DateTime.now().subtract(const Duration(hours: 3)),
              completed: true,
            ),
            TimelineStep(
              title: 'Payment initiated',
              time: DateTime.now()
                  .subtract(const Duration(hours: 2, minutes: 30)),
              completed: true,
            ),
            TimelineStep(
              title: 'Payment completed',
              time: DateTime.now().subtract(const Duration(hours: 2)),
              completed: true,
            ),
          ],
        ),
        TransactionModel(
          type: TransactionType.invoice,
          title: 'Invoice #123',
          amount: '+500',
          currency: 'USDT',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          status: TransactionStatus.successful,
          network: 'Ethereum',
          fromAddress: '0×6885afa...6f23b3',
          transactionId: '0×6885afa...63b3',
          date: DateTime.now().subtract(const Duration(days: 1)),
          billedTo: 'Adegboyega Oluwagbemiro',
          invoiceId: '#INV-2025-001',
          timeline: [
            TimelineStep(
              title: 'Invoice created',
              time: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
              completed: true,
            ),
            TimelineStep(
              title: 'Payment initiated',
              time:
                  DateTime.now().subtract(const Duration(days: 1, minutes: 30)),
              completed: true,
            ),
            TimelineStep(
              title: 'Payment completed',
              time: DateTime.now().subtract(const Duration(days: 1)),
              completed: true,
            ),
          ],
        ),
        TransactionModel(
          type: TransactionType.quickpay,
          title: 'QuickPay Transfer',
          amount: '-200',
          currency: 'USDT',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          status: TransactionStatus.failed,
          network: 'Ethereum',
          fromAddress: '0×6885afa...6f23b3',
          transactionId: '0×6885afa...63b3',
          date: DateTime.now().subtract(const Duration(days: 1)),
          recipient: 'John Doe',
          paymentMethod: 'Bank Transfer',
        ),
      ];

      // Filter by type, status, date, and search
      List<TransactionModel> filtered = mockTransactions.where((tx) {
        final typeStr = tx.type.toString().split('.').last;
        final typeMatch = event.types.contains('All') ||
            event.types.map((e) => e.toLowerCase()).contains(typeStr);
        final statusStr = tx.status.toString().split('.').last;
        final statusMatch =
            event.status == 'All' || event.status.toLowerCase() == statusStr;
        final dateMatch = (event.startDate == null ||
                !tx.timestamp.isBefore(event.startDate!)) &&
            (event.endDate == null || !tx.timestamp.isAfter(event.endDate!));
        final searchLower = event.search.toLowerCase();
        final searchMatch = event.search.isEmpty ||
            tx.title.toLowerCase().contains(searchLower) ||
            tx.amount.toLowerCase().contains(searchLower);
        return typeMatch && statusMatch && dateMatch && searchMatch;
      }).toList();

      // Group by date
      final transactionsByDate = <DateTime, List<TransactionModel>>{};
      for (var transaction in filtered) {
        final date = DateTime(
          transaction.timestamp.year,
          transaction.timestamp.month,
          transaction.timestamp.day,
        );
        transactionsByDate.putIfAbsent(date, () => []).add(transaction);
      }
      final sortedDates = transactionsByDate.keys.toList()
        ..sort((a, b) => b.compareTo(a));
      final sortedTransactionsByDate = Map.fromEntries(
        sortedDates.map((date) => MapEntry(date, transactionsByDate[date]!)),
      );
      emit(TransactionLoaded(sortedTransactionsByDate));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}
