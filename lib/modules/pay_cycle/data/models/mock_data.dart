import '../models/contract.dart';
import '../models/payment_history.dart';

class MockData {
  static List<PayCycleContract> get contracts => [
    PayCycleContract(
      id: '1',
      title: 'DefiFundr Mobile & Web App Re...',
      type: ContractType.fixedRate,
      rate: '581 USDT',
      frequency: PayCycleFrequency.perMonth,
      isActive: true,
      clientName: 'DefiFundr Corp.',
      workSubmissions: [],
    ),
    PayCycleContract(
      id: '2',
      title: 'Quikdash Mobile & Web App Redesign',
      type: ContractType.milestone,
      rate: '581 STRK',
      frequency: PayCycleFrequency.perDeliverable,
      isActive: true,
      clientName: 'Quikdash Inc.',
      milestones: [
        Milestone(
          id: 'm1',
          title: 'User Flow & Wireframe Design',
          amount: 21,
          currency: 'USDT',
          status: PaymentStatus.awaitingPayment,
          invoiceNumber: '#INV-2025-010',
          description: 'Creating high-fidelity wireframes and user flow diagrams for the mobile redesign.',
          attachmentPath: 'wireframes.pdf',
          submissionDate: DateTime(2025, 5, 20),
          dueDate: DateTime(2025, 5, 31),
        ),
        Milestone(
          id: 'm1_b',
          title: 'Initial Branding & Color Palette',
          amount: 15,
          currency: 'USDT',
          status: PaymentStatus.awaitingPayment,
          invoiceNumber: '#INV-2025-011',
          description: 'Developing the brand identity, including color palette, typography and logo variations.',
          attachmentPath: 'branding_guide.pdf',
          submissionDate: DateTime(2025, 5, 20),
          dueDate: DateTime(2025, 5, 31),
        ),
        Milestone(
          id: 'm2',
          title: 'High-Fidelity UI for Mobile App',
          amount: 42,
          currency: 'USDT',
          status: PaymentStatus.paid,
          invoiceNumber: '#INV-2025-010',
          description: 'Designing the final UI screens for the main mobile features.',
          attachmentPath: 'mobile_ui_final.pdf',
          submissionDate: DateTime(2025, 5, 20),
          dueDate: DateTime(2025, 5, 31),
        ),
        Milestone(
          id: 'm3',
          title: 'High-Fidelity UI for Web Dashboard',
          amount: 53,
          currency: 'USDT',
          status: PaymentStatus.pendingApproval, 
          dueDate: DateTime(2025, 5, 23),
          submissionDate: DateTime(2025, 5, 18),
          description: 'Expanding the design system to the web dashboard and internal admin tools.',
          attachmentPath: 'web_dashboard.pdf',
        ),
        Milestone(
          id: 'm4',
          title: 'Final Design Assets & Documentation',
          amount: 33,
          currency: 'USDT',
          status: PaymentStatus.pendingApproval, 
          dueDate: DateTime(2025, 5, 23),
          submissionDate: DateTime(2025, 5, 18),
          description: 'Exporting assets and creating handover documentation for the engineering team.',
          attachmentPath: 'handover_doc.pdf',
        ),
        Milestone(
          id: 'm5',
          title: 'Responsive Web Design Final Polish',
          amount: 41,
          currency: 'USDT',
          status: PaymentStatus.pendingSubmission, 
          dueDate: DateTime(2025, 5, 31),
          description: 'Refining the responsive layouts and cross-browser testing for the landing page.',
        ),
        Milestone(
          id: 'm6',
          title: 'Component Library Documentation',
          amount: 18,
          currency: 'USDT',
          status: PaymentStatus.overdue, 
          dueDate: DateTime(2025, 5, 10),
          description: 'Documenting the reusable UI components for the design system library.',
        ),
      ],
      workSubmissions: [],
    ),
    PayCycleContract(
      id: '3',
      title: 'Weave Finance Mobile & Web A...',
      type: ContractType.payAsYouGo,
      rate: '50 EURt',
      frequency: PayCycleFrequency.perDeliverable,
      isActive: true,
      workSubmissions: [],
    ),
    PayCycleContract(
      id: '4',
      title: 'BlockLayer Validator Integration...',
      type: ContractType.payAsYouGo,
      rate: '21 USDC',
      frequency: PayCycleFrequency.perHour,
      isActive: true,
      clientName: 'Adegboyega Oluwagbemiro',
      workSubmissions: [],
    ),
    PayCycleContract(
      id: '5',
      title: 'Legaltide Compliance Audit for...',
      type: ContractType.payAsYouGo,
      rate: '51 LUSD',
      frequency: PayCycleFrequency.perDay,
      isActive: true,
      workSubmissions: [],
    ),
    PayCycleContract(
      id: '6',
      title: 'Snapworks Product Photograph...',
      type: ContractType.payAsYouGo,
      rate: '101 DAI',
      frequency: PayCycleFrequency.perWeek,
      isActive: true,
      workSubmissions: [],
    ),
  ];

  static List<WorkSubmission> getWorkSubmissions(String contractId) {
    if (contractId == '3') {
      // Per Deliverable
      return [
        WorkSubmission(
          id: 'ws_del_1',
          quantity: 1,
          unit: 'deliverable',
          amount: 33,
          currency: 'USDT',
          submissionDate: DateTime(2025, 5, 14),
          workDate: DateTime(2025, 5, 14),
          status: PaymentStatus.pendingApproval,
          description: 'Onboarding Flow Optimization for Mobile',
          attachmentPath: 'onboarding_fix.pdf',
        ),
        WorkSubmission(
          id: 'ws_del_2',
          quantity: 1,
          unit: 'deliverable',
          amount: 33,
          currency: 'USDT',
          submissionDate: DateTime(2025, 5, 14),
          workDate: DateTime(2025, 5, 14),
          status: PaymentStatus.pendingApproval,
          description: 'Payment Gateway Integration for Web',
          attachmentPath: 'payment_gw.pdf',
        ),
        WorkSubmission(
          id: 'ws_del_3',
          quantity: 1,
          unit: 'deliverable',
          amount: 33,
          currency: 'USDT',
          submissionDate: DateTime(2025, 5, 14),
          workDate: DateTime(2025, 5, 14),
          status: PaymentStatus.approved,
          description: 'Content Upload Automation Script',
          attachmentPath: 'script.zip',
        ),
        WorkSubmission(
          id: 'ws_del_4',
          quantity: 1,
          unit: 'deliverable',
          amount: 33,
          currency: 'USDT',
          submissionDate: DateTime(2025, 5, 14),
          workDate: DateTime(2025, 5, 14),
          status: PaymentStatus.approved,
          description: 'Mobile App Push Notification System',
          attachmentPath: 'push_notes.pdf',
        ),
        WorkSubmission(
          id: 'ws_del_rejected',
          quantity: 1,
          unit: 'deliverable',
          amount: 33,
          currency: 'USDT',
          submissionDate: DateTime(2025, 5, 14),
          workDate: DateTime(2025, 5, 14),
          status: PaymentStatus.rejected,
          rejectionReason: 'The design assets were missing the required dimensions for social media previews.',
          description: 'Social Media Asset Pack Design',
          attachmentPath: 'social_assets.zip',
        ),
      ];
    } else if (contractId == '5') {
      // Per Day
      return [
        WorkSubmission(
          id: 'ws_day_1',
          quantity: 4,
          unit: 'days',
          amount: 400,
          currency: 'USDT',
          submissionDate: DateTime(2025, 5, 31),
          workDate: DateTime(2025, 5, 31),
          status: PaymentStatus.pendingApproval,
          description:
              'Refactored the user onboarding process to reduce friction, added progress indicators, and updated form validations for a smoother user experience.',
          attachmentPath: 'File name.pdf',
          breakdown: [
            WorkBreakdownItem(
                label: 'Mon 12 May 2025', timeRange: '', duration: '1 day'),
            WorkBreakdownItem(
                label: 'Wed 14 May 2025', timeRange: '', duration: '1 day'),
            WorkBreakdownItem(
                label: 'Fri 16 May 2025', timeRange: '', duration: '1 day'),
            WorkBreakdownItem(
                label: 'Sat 17 May 2025', timeRange: '', duration: '1 day'),
          ],
        ),
        WorkSubmission(
          id: 'ws_day_2',
          quantity: 4,
          unit: 'days',
          amount: 400,
          currency: 'USDT',
          submissionDate: DateTime(2025, 5, 31),
          workDate: DateTime(2025, 5, 31),
          status: PaymentStatus.approved,
          description:
              'Refactored the user onboarding process to reduce friction, added progress indicators, and updated form validations for a smoother user experience.',
          attachmentPath: 'File name.pdf',
          invoiceNumber: '#INV-2025-001',
          breakdown: [
            WorkBreakdownItem(
                label: 'Mon 12 May 2025', timeRange: '', duration: '1 day'),
            WorkBreakdownItem(
                label: 'Wed 14 May 2025', timeRange: '', duration: '1 day'),
            WorkBreakdownItem(
                label: 'Fri 16 May 2025', timeRange: '', duration: '1 day'),
            WorkBreakdownItem(
                label: 'Sat 17 May 2025', timeRange: '', duration: '1 day'),
          ],
        ),
        WorkSubmission(
          id: 'ws_day_rejected',
          quantity: 1,
          unit: 'days',
          amount: 100,
          currency: 'USDT',
          submissionDate: DateTime(2025, 5, 14),
          workDate: DateTime(2025, 5, 14),
          status: PaymentStatus.rejected,
          rejectionReason:
              'The report for this workday was incomplete and lacked sufficient details on the tasks completed.',
          description: 'Full day of compliance auditing.',
          attachmentPath: 'audit_report.pdf',
          breakdown: [
            WorkBreakdownItem(
                label: 'Tue 13 May 2025', timeRange: '', duration: '1 day'),
          ],
        ),
      ];
    }
    // Default/Per Hour (Contract 4)
    return [
      WorkSubmission(
        id: 'ws1',
        quantity: 12.35,
        unit: 'hours',
        amount: 400,
        currency: 'USDT',
        submissionDate: DateTime(2025, 5, 31),
        workDate: DateTime(2025, 5, 31),
        status: PaymentStatus.pendingApproval,
        description:
            'Refactored the user onboarding process to reduce friction, added progress indicators, and updated form validations for a smoother user experience.',
        attachmentPath: 'file_name.pdf',
        breakdown: [
          WorkBreakdownItem(
            label: 'Regular hours',
            timeRange: '12:40 – 15:40',
            duration: '3h 0m',
          ),
          WorkBreakdownItem(
            label: 'Break',
            timeRange: '15:40 – 16:10',
            duration: '30m',
          ),
          WorkBreakdownItem(
            label: 'Regular hours',
            timeRange: '16:10 – 18:10',
            duration: '2h 0m',
          ),
          WorkBreakdownItem(
            label: 'Overtime',
            timeRange: '18:10 – 19:39',
            duration: '1h 29m',
          ),
        ],
      ),
      WorkSubmission(
        id: 'ws2',
        quantity: 12.35,
        unit: 'hours',
        amount: 400,
        currency: 'USDT',
        submissionDate: DateTime(2025, 5, 31),
        workDate: DateTime(2025, 5, 31),
        status: PaymentStatus.approved,
        description:
            'Refactored the user onboarding process to reduce friction, added progress indicators, and updated form validations for a smoother user experience.',
        attachmentPath: 'file_name.pdf',
        invoiceNumber: '#INV-2025-001',
        breakdown: [
          WorkBreakdownItem(
            label: 'Regular hours',
            timeRange: '12:40 – 15:40',
            duration: '3h 0m',
          ),
          WorkBreakdownItem(
            label: 'Break',
            timeRange: '15:40 – 16:10',
            duration: '30m',
          ),
          WorkBreakdownItem(
            label: 'Regular hours',
            timeRange: '16:10 – 18:10',
            duration: '2h 0m',
          ),
          WorkBreakdownItem(
            label: 'Overtime',
            timeRange: '18:10 – 19:39',
            duration: '1h 29m',
          ),
        ],
      ),
      WorkSubmission(
        id: 'ws_rejected',
        quantity: 7.5372,
        unit: 'hours',
        amount: 33,
        currency: 'USDT',
        submissionDate: DateTime(2025, 5, 14),
        workDate: DateTime(2025, 5, 14),
        status: PaymentStatus.rejected,
        rejectionReason:
            'Post-optimization logs showed a spike in timeout errors, and the performance gains weren’t consistent under load.',
        description:
            'Refactored the user onboarding process to reduce friction, added progress indicators, and updated form validations for a smoother user experience.',
        attachmentPath: 'file_name.pdf',
        breakdown: [
          WorkBreakdownItem(
            label: 'Regular hours',
            timeRange: '12:40 – 15:40',
            duration: '3h 0m',
          ),
          WorkBreakdownItem(
            label: 'Break',
            timeRange: '15:40 – 16:10',
            duration: '30m',
          ),
          WorkBreakdownItem(
            label: 'Regular hours',
            timeRange: '16:10 – 18:10',
            duration: '2h 0m',
          ),
          WorkBreakdownItem(
            label: 'Overtime',
            timeRange: '18:10 – 19:39',
            duration: '1h 29m',
          ),
        ],
      ),
    ];
  }

  static PayCycleContract? getContractById(String id) {
    try {
      return contracts.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<Payout> getPayouts(String contractId) {
    switch (contractId) {
      case '1': // DefiFundr - Fixed Rate
        return [
          Payout(
            id: 'df_pay_1',
            invoiceNumber: '#INV-2025-015',
            status: PaymentStatus.awaitingPayment,
            startDate: DateTime(2025, 4, 1),
            endDate: DateTime(2025, 4, 30),
            submissionDate: DateTime(2025, 5, 1),
            dueDate: DateTime(2025, 5, 15),
            amount: 581,
            currency: 'USDT',
            contractId: contractId,
            contractTitle: 'DefiFundr Mobile & Web App Re...',
            clientName: 'DefiFundr Corp.',
          ),
          Payout(
            id: 'df_pay_2',
            invoiceNumber: '#INV-2025-014',
            status: PaymentStatus.paid,
            startDate: DateTime(2025, 3, 1),
            endDate: DateTime(2025, 3, 31),
            submissionDate: DateTime(2025, 4, 1),
            dueDate: DateTime(2025, 4, 15),
            amount: 581,
            currency: 'USDT',
            contractId: contractId,
            contractTitle: 'DefiFundr Mobile & Web App Re...',
            clientName: 'DefiFundr Corp.',
          ),
        ];
      case '2': // Quikdash
        return [];
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
        ];
      default:
        return [];
    }
  }

  static List<PaymentHistoryItem> getPaymentHistory(String contractId) {
    switch (contractId) {
      case '1':
        return [
           PaymentHistoryItem(
            id: 'df_hist_1',
            startDate: DateTime(2025, 3, 1),
            endDate: DateTime(2025, 3, 31),
            submissionDate: DateTime(2025, 4, 1),
            amount: 581,
            currency: 'USDT',
            status: PaymentStatus.paid,
            invoiceNumber: '#INV-2025-014',
          ),
        ];
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
            invoiceNumber: '#INV-2025-001',
          ),
          PaymentHistoryItem(
            id: 'hist_2',
            startDate: DateTime(2025, 2, 1),
            endDate: DateTime(2025, 2, 28),
            submissionDate: DateTime(2025, 5, 20),
            amount: 33,
            currency: 'USDT',
            status: PaymentStatus.paid,
            invoiceNumber: '#INV-2025-002',
          ),
        ];
      case '3': // Weave Finance
      case '4': // BlockLayer
      case '5': // Legaltide
      case '6': // Snapworks
        return [
          PaymentHistoryItem(
            id: 'hist_payg_1',
            startDate: DateTime(2025, 3, 1),
            endDate: DateTime(2025, 3, 31),
            submissionDate: DateTime(2025, 5, 20),
            amount: 33,
            currency: 'USDT',
            status: PaymentStatus.overdue,
            invoiceNumber: '#INV-2025-001',
          ),
          PaymentHistoryItem(
            id: 'hist_payg_2',
            startDate: DateTime(2025, 2, 1),
            endDate: DateTime(2025, 2, 28),
            submissionDate: DateTime(2025, 5, 20),
            amount: 33,
            currency: 'USDT',
            status: PaymentStatus.paid,
            invoiceNumber: '#INV-2025-002',
          ),
        ];
      default:
        return [];
    }
  }
}
