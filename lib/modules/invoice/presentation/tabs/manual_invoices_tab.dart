import 'package:auto_route/auto_route.dart';
import 'package:defifundr_mobile/core/routers/routers.dart'
    show InvoiceDetailRoute;
import 'package:defifundr_mobile/modules/invoice/data/models/app_%20constants.dart';
import 'package:defifundr_mobile/modules/invoice/data/models/invoice_models.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/common/empty_state.dart';
import 'package:defifundr_mobile/modules/invoice/presentation/widgets/invoice_card.dart';
import 'package:flutter/material.dart';
import 'package:defifundr_mobile/core/gen/assets.gen.dart';

class ManualInvoicesTab extends StatelessWidget {
  const ManualInvoicesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Invoice> invoices = AppConstants.sampleManualInvoices;

    if (invoices.isEmpty) {
      return EmptyState(
        icon: Assets.icons.emptyInvoice,
        title: 'No invoices yet.',
        subtitle:
            'Once you create or receive one, you\'ll see it listed\nhere.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        return InvoiceCard(
          invoice: invoices[index],
          onTap: () {
            context.router.push(InvoiceDetailRoute(invoice: invoices[index]));
          },
        );
      },
    );
  }
}
