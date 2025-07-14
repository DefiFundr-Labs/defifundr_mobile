import '../models/contract.dart';
import '../models/payment_history.dart';

class MockData {
  static final List<Contract> contracts = [
    Contract(
      id: '1',
      title: 'DefiFundr Mobile & Web App Re...',
      type: ContractType.fixedRate,
      rate: '581 USDT',
      frequency: 'Every month',
      isActive: true,
    ),
    Contract(
      id: '2',
      title: 'Quikdash Mobile & Web App Re...',
      type: ContractType.milestone,
      rate: '581 STRK',
      frequency: '5 milestones',
      isActive: true,
    ),
    Contract(
      id: '3',
      title: 'Weave Finance Mobile & Web A...',
      type: ContractType.payAsYouGo,
      rate: '50 EURt',
      frequency: 'Per Deliverable',
      isActive: true,
    ),
    Contract(
      id: '4',
      title: 'BlockLayer Validator Integration...',
      type: ContractType.payAsYouGo,
      rate: '21 USDC',
      frequency: 'Per Hour',
      isActive: true,
    ),
    Contract(
      id: '5',
      title: 'Legaltide Compliance Audit for...',
      type: ContractType.payAsYouGo,
      rate: '51 LUSD',
      frequency: 'Per Day',
      isActive: true,
    ),
    Contract(
      id: '6',
      title: 'Snapworks Product Photograph...',
      type: ContractType.payAsYouGo,
      rate: '101 DAI',
      frequency: 'Per Week',
      isActive: true,
    ),
  ];

  static List<Payout> getPayouts(String contractId) {
    switch (contractId) {
      case '2': // Quikdash
        return [
          Payout(
            id: 'pay_1',
            invoiceNumber: '#INV-2025-001',
            status: PaymentStatus.approved,
            startDate: DateTime(2025, 5, 1),
            endDate: DateTime(2025, 5, 31),
            submissionDate: DateTime(2025, 5, 14),
            dueDate: DateTime(2025, 5, 31),
            amount: 33,
            currency: 'USDT',
            contractId: contractId,
            contractTitle: 'Quikdash Mobile & Web App Re...',
            clientName: 'Quikdash Inc.',
          ),
        ];
      case '4': // BlockLayer
        return [
          Payout(
            id: 'pay_2',
            invoiceNumber: '#INV-2025-001',
            status: PaymentStatus.overdue,
            startDate: DateTime(2025, 5, 1),
            endDate: DateTime(2025, 5, 31),
            submissionDate: DateTime(2025, 5, 18),
            dueDate: DateTime(2025, 5, 31),
            amount: 141,
            currency: 'USDT',
            contractId: contractId,
            contractTitle: 'BlockLayer Validator Inte...',
            clientName: 'Adegboyega Oluwagbemiro',
          ),
          Payout(
            id: 'pay_3',
            invoiceNumber: '#INV-2025-002',
            status: PaymentStatus.pending,
            startDate: DateTime(2025, 5, 1),
            endDate: DateTime(2025, 5, 31),
            submissionDate: DateTime(2025, 5, 18),
            dueDate: DateTime(2025, 5, 31),
            amount: 141,
            currency: 'USDT',
            contractId: contractId,
            contractTitle: 'BlockLayer Validator Inte...',
            clientName: 'Adegboyega Oluwagbemiro',
          ),
        ];
      default:
        return [];
    }
  }

  static List<PaymentHistoryItem> getPaymentHistory(String contractId) {
    switch (contractId) {
      case '2': // Quikdash
        return [
          PaymentHistoryItem(
            id: 'hist_1',
            startDate: DateTime(2025, 3, 1),
            endDate: DateTime(2025, 3, 31),
            submissionDate: DateTime(2025, 5, 20),
            amount: 33,
            currency: 'USDT',
            status: PaymentStatus.overdue,
          ),
          PaymentHistoryItem(
            id: 'hist_2',
            startDate: DateTime(2025, 2, 1),
            endDate: DateTime(2025, 2, 28),
            submissionDate: DateTime(2025, 5, 20),
            amount: 33,
            currency: 'USDT',
            status: PaymentStatus.paid,
          ),
        ];
      case '4': // BlockLayer
        return [
          PaymentHistoryItem(
            id: 'hist_3',
            startDate: DateTime(2025, 3, 1),
            endDate: DateTime(2025, 3, 31),
            submissionDate: DateTime(2025, 5, 20),
            amount: 33,
            currency: 'USDT',
            status: PaymentStatus.overdue,
          ),
          PaymentHistoryItem(
            id: 'hist_4',
            startDate: DateTime(2025, 2, 1),
            endDate: DateTime(2025, 2, 28),
            submissionDate: DateTime(2025, 5, 20),
            amount: 33,
            currency: 'USDT',
            status: PaymentStatus.paid,
          ),
        ];
      default:
        return [];
    }
  }
}
