import 'dart:ui';

import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';

class AppConstants {
  static const String appTitle = 'Invoice App';
  static const String fontFamily = 'SF Pro Display';

  // Colors
  static const primaryBlue = Color(0xFF2196F3);
  static const backgroundColor = Color(0xFFF5F5F5);
  static const cardColor = Color(0xFFFFFFFF);

  // Sample data
  static List<Invoice> get sampleManualInvoices => [
        Invoice(
          id: 'INV-2025-010',
          title: 'Quikdash Mobile App Redesign',
          client: 'Brightfolk Ltd',
          amount: '581 USDT',
          issueDate: '19 May 2025',
          status: InvoiceStatus.pending,
        ),
        Invoice(
          id: 'INV-2025-009',
          title: 'Custom CRM Automation',
          client: 'GrowthAmp Inc',
          amount: '1,920 DAI',
          issueDate: '18 May 2025',
          status: InvoiceStatus.paid,
        ),
        Invoice(
          id: 'INV-2025-008',
          title: 'eCommerce UI Revamp',
          client: 'ShopLink Pro',
          amount: '581 USDT',
          issueDate: '17 May 2025',
          status: InvoiceStatus.overdue,
        ),
      ];

  static List<Invoice> get sampleContractInvoices => [
        Invoice(
          id: 'INV-2025-010',
          title: 'For May 5th - May 11th 2025',
          client: 'Quikdash Mobile & Web App Redesign',
          amount: '1,030 DAI',
          issueDate: '11 May 2025',
          status: InvoiceStatus.pending,
        ),
        Invoice(
          id: 'INV-2025-009',
          title: 'For Apr 28th - May 4th 2025',
          client: 'Neurolytix LLC AI Dataset Cleanup',
          amount: '530 USDD',
          issueDate: '25 Oct 2025',
          status: InvoiceStatus.paid,
        ),
      ];
}
