import 'package:defifundr_mobile/modules/invoice/presentation/screens/invoice_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InvoiceDetailView extends StatelessWidget {
  final Invoice invoice;

  InvoiceDetailView({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          invoice.id,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Status Alert (only for overdue)
            if (invoice.status == InvoiceStatus.overdue)
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  border: Border.all(color: Colors.red[200]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.red, size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Invoice Overdue',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.red[700],
                            ),
                          ),
                          Text(
                            'Contact your client if they\'ve initiated payment for your invoice.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Amount Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Amount Circle Icon
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.receipt,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Amount
                  Text(
                    invoice.amount,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '≈ \$476.19',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),

            // Invoice Details Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildDetailRow('Status', '',
                      statusWidget: _buildStatusChip(invoice.status)),
                  _buildDetailRow('Invoice no', invoice.id),
                  _buildDetailRow(
                      'Title', 'Neurolytix Initial consultation...'),
                  _buildDetailRow('Network', 'Ethereum',
                      hasIcon: true, iconColor: Colors.blue),
                  _buildDetailRow('Asset', 'USDT',
                      hasIcon: true, iconColor: Colors.green, iconText: 'T'),
                  _buildDetailRow('Issue date', '15 April 2025'),
                  _buildDetailRow('Due date', '29 April 2025'),
                  if (invoice.status == InvoiceStatus.paid) ...[
                    _buildDetailRow('Transaction ID', '0x68854e...6363',
                        isCopyable: true),
                    _buildDetailRow('Payment date', '29 April 2025'),
                  ],
                ],
              ),
            ),

            SizedBox(height: 24),

            // Billed To Section
            _buildSection(
              'Billed To',
              [
                _buildDetailRow('Name', 'Adegboyega Oluwagbemiro'),
                _buildDetailRow('Email', 'adeshinaadegboyega@icloud.com'),
                _buildDetailRow('Phone no', '+234 (801) 234 5678'),
                _buildDetailRow('Country', 'Nigeria', hasFlag: true),
                _buildDetailRow('Address',
                    'No 8 James Robertson Shittu/\nOgunlana Drive, Surulere | 142261'),
              ],
            ),

            SizedBox(height: 24),

            // Billed From Section
            _buildSection(
              'Billed From',
              [
                _buildDetailRow('Name', 'Adegboyega Oluwagbemiro'),
                _buildDetailRow('Email', 'adeshinaadegboyega@icloud.com'),
                _buildDetailRow('Phone no', '+234 (801) 234 5678'),
                _buildDetailRow('Country', 'Nigeria', hasFlag: true),
                _buildDetailRow('Address',
                    'No 8 James Robertson Shittu/\nOgunlana Drive, Surulere | 142261'),
              ],
            ),

            SizedBox(height: 24),

            // Invoice Breakdown Section
            _buildSection(
              'Invoice Breakdown',
              [
                _buildInvoiceItem(
                    'Item Name', '500 USDT', '100 unit(s) at 5 USDT'),
                _buildInvoiceItem(
                    'Item Name', '80 USDT', '10 unit(s) at 8 USDT'),
                Divider(color: Colors.grey[200]),
                _buildSummaryRow('Subtotal', '580 USDT'),
                _buildSummaryRow('VAT (20%)', '1 USDT'),
                Divider(color: Colors.grey[200], thickness: 2),
                _buildSummaryRow('Total Amount', '581 USDT', isTotal: true),
              ],
            ),

            SizedBox(height: 24),

            // Payment Tracker Section
            _buildPaymentTrackerSection(),

            SizedBox(height: 24),

            // Payment Memo Section
            _buildSection(
              'Payment Memo',
              [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Thank you for your business. Please remit payment according to the terms outlined in this invoice. If you have any questions regarding this invoice or the payment process, do not hesitate to contact us.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 32),

            // Action Buttons
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Preview PDF functionality
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey[300]!),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.visibility,
                              color: Colors.grey[600], size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Preview PDF',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Download PDF functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.download, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Download PDF',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[200]),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    Widget? statusWidget,
    bool hasIcon = false,
    Color? iconColor,
    String? iconText,
    bool hasFlag = false,
    bool isCopyable = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                if (hasFlag) ...[
                  Container(
                    width: 20,
                    height: 14,
                    margin: EdgeInsets.only(right: 8, top: 2),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
                if (hasIcon) ...[
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(right: 8, top: 1),
                    decoration: BoxDecoration(
                      color: iconColor,
                      shape: BoxShape.circle,
                    ),
                    child: iconText != null
                        ? Center(
                            child: Text(
                              iconText,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.currency_bitcoin,
                            color: Colors.white,
                            size: 12,
                          ),
                  ),
                ],
                if (statusWidget != null)
                  statusWidget
                else
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                if (isCopyable)
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: value));
                    },
                    child: Icon(
                      Icons.copy,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(InvoiceStatus status) {
    Color backgroundColor;
    Color textColor;
    String text;

    switch (status) {
      case InvoiceStatus.pending:
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        text = 'Pending';
        break;
      case InvoiceStatus.paid:
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        text = 'Paid';
        break;
      case InvoiceStatus.overdue:
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        text = 'Overdue';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildInvoiceItem(String itemName, String amount, String description) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              itemName,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTrackerSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Payment Tracker',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[200]),

          // Payment tracker items based on status
          if (invoice.status == InvoiceStatus.overdue) ...[
            _buildTrackerItem(
              icon: Icons.check_circle,
              iconColor: Colors.green,
              title: 'Invoice created and sent to client',
              subtitle: '20th April 2025, 04:40 PM',
              isCompleted: true,
            ),
            _buildTrackerItem(
              icon: Icons.warning,
              iconColor: Colors.orange,
              title: 'Client payment overdue',
              subtitle:
                  'The payment was due on 31st May 2025 but has not yet been received.',
              isCompleted: false,
            ),
            _buildTrackerItem(
              icon: Icons.radio_button_unchecked,
              iconColor: Colors.grey,
              title: 'Process your client payment',
              subtitle: '',
              isCompleted: false,
            ),
            _buildTrackerItem(
              icon: Icons.radio_button_unchecked,
              iconColor: Colors.grey,
              title:
                  'According to your invoice, funds will be reflected in your balance on 31st May 2025',
              subtitle: '',
              isCompleted: false,
            ),
          ] else if (invoice.status == InvoiceStatus.paid) ...[
            _buildTrackerItem(
              icon: Icons.check_circle,
              iconColor: Colors.green,
              title: 'Invoice created and sent to client',
              subtitle: '20th April 2025, 04:40 PM',
              isCompleted: true,
            ),
            _buildTrackerItem(
              icon: Icons.check_circle,
              iconColor: Colors.green,
              title: 'Client payment confirmed',
              subtitle: '20th April 2025, 08:40 PM',
              isCompleted: true,
            ),
            _buildTrackerItem(
              icon: Icons.check_circle,
              iconColor: Colors.green,
              title: 'Client payment processed',
              subtitle: '20th April 2025, 08:45 PM',
              isCompleted: true,
            ),
            _buildTrackerItem(
              icon: Icons.check_circle,
              iconColor: Colors.green,
              title: 'Funds received in your account',
              subtitle: '20th April 2025, 08:45 PM',
              isCompleted: true,
            ),
          ] else if (invoice.status == InvoiceStatus.pending) ...[
            _buildTrackerItem(
              icon: Icons.check_circle,
              iconColor: Colors.green,
              title: 'Invoice created and sent to client',
              subtitle: '20th April 2025, 04:40 PM',
              isCompleted: true,
            ),
            _buildTrackerItem(
              icon: Icons.access_time,
              iconColor: Colors.orange,
              title: 'Awaiting payment confirmation',
              subtitle:
                  'Your client will get invoice access before it is due on 31st May 2025.',
              isCompleted: false,
            ),
            _buildTrackerItem(
              icon: Icons.radio_button_unchecked,
              iconColor: Colors.grey,
              title: 'Process your client payment',
              subtitle: '',
              isCompleted: false,
            ),
            _buildTrackerItem(
              icon: Icons.radio_button_unchecked,
              iconColor: Colors.grey,
              title:
                  'According to your invoice, funds will be reflected in your balance on 31st May 2025',
              subtitle: '',
              isCompleted: false,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTrackerItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool isCompleted,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isCompleted ? Colors.black : Colors.grey[600],
                  ),
                ),
                if (subtitle.isNotEmpty) ...[
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Extended Invoice class with additional properties for detail view
class DetailedInvoice extends Invoice {
  final String transactionId;
  final DateTime? paymentDate;

  DetailedInvoice({
    required String id,
    required String title,
    required String client,
    required String amount,
    required String issueDate,
    required InvoiceStatus status,
    this.transactionId = '',
    this.paymentDate,
  }) : super(
          id: id,
          title: title,
          client: client,
          amount: amount,
          issueDate: issueDate,
          status: status,
        );
}

// Usage example - how to navigate to invoice detail
class InvoiceListItem extends StatelessWidget {
  final Invoice invoice;

  InvoiceListItem({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InvoiceDetailView(invoice: invoice),
          ),
        );
      },
      child: Container(
        // Your existing invoice card design
        child: Text('Invoice ${invoice.id}'),
      ),
    );
  }
}

// Sample data for testing different states
class SampleInvoices {
  static DetailedInvoice get overdueInvoice => DetailedInvoice(
        id: '#INV-607',
        title: 'Neurolytix Initial consultation',
        client: 'Adegboyega Oluwagbemiro',
        amount: '581 USDT',
        issueDate: '15 April 2025',
        status: InvoiceStatus.overdue,
      );

  static DetailedInvoice get paidInvoice => DetailedInvoice(
        id: '#INV-607',
        title: 'Neurolytix Initial consultation',
        client: 'Adegboyega Oluwagbemiro',
        amount: '581 USDT',
        issueDate: '15 April 2025',
        status: InvoiceStatus.paid,
        transactionId: '0x68854e...6363',
        paymentDate: DateTime(2025, 4, 29),
      );

  static DetailedInvoice get pendingInvoice => DetailedInvoice(
        id: '#INV-607',
        title: 'Neurolytix Initial consultation',
        client: 'Adegboyega Oluwagbemiro',
        amount: '581 USDT',
        issueDate: '15 April 2025',
        status: InvoiceStatus.pending,
      );
}
