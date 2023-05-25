import 'package:common_di/common_di.dart';
import 'package:common_ui/common_bloc.dart';
import 'package:common_ui/common_resource.dart';
import 'package:common_ui/common_style.dart';
import 'package:common_ui/common_widget.dart';
import 'package:common_ui/nullable_extension.dart';
import 'package:common_ui/number_extension.dart';
import 'package:flutter/material.dart';
import 'package:payment_domain/payment_domain.dart';
import '../bloc/invoice_detail_bloc.dart';
import '../bloc/invoice_detail_state.dart';
import '../bloc/invoice_detail_event.dart';

class InvoiceDetailPage extends StatelessWidget with Injectable {
  const InvoiceDetailPage({required this.invoiceId, Key? key})
      : super(key: key);

  final String invoiceId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InvoiceDetailBloc(inject())
        ..add(
          LoadInvoice(id: invoiceId),
        ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              children: [
                _body(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 1024,
        minWidth: 500,
      ),
      decoration: CommonDecorations.boxOutlined(radius: 4),
      padding: const EdgeInsets.all(8),
      child: BlocBuilder<InvoiceDetailBloc, InvoiceDetailState>(
        builder: (context, state) {
          final invoice = state.invoice;
          if (state.isLoading == true || invoice == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              constraints: const BoxConstraints(
                maxWidth: 1024,
              ),
              child: _table(invoice),
            ),
          );
        },
      ),
    );
  }

  Widget _table(Invoice invoice) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            ImageResources.iconTitle,
            opacity: const AlwaysStoppedAnimation(.5),
          ),
        ),
        Text(
          'INVOICE',
          style: CommonTypography.textHeading2.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "No. ${invoice.id}",
          style: CommonTypography.textBody,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "To",
                  style: CommonTypography.textBody,
                ),
                const SizedBox(height: 8),
                Text(
                  invoice.email.orEmpty(),
                  style: CommonTypography.textBodyBold,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Date",
                  style: CommonTypography.textBody,
                ),
                const SizedBox(height: 8),
                Text(
                  invoice.createdAt.orEmpty(),
                  style: CommonTypography.textBodyBold,
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Table(
          border: TableBorder.all(
            color: CommonColors.separatorLineColor,
          ),
          columnWidths: const {0: FlexColumnWidth(), 1: FixedColumnWidth(200)},
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            _row("Description", "Price", isHeader: true),
            _row(invoice.name.orEmpty(), invoice.amount.toIDR()),
            _row("Admin Fee", (invoice.adminFee.orZero()).toIDR()),
            _row("Total", invoice.getTotal().toIDR(), isTotal: true),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  TableRow _row(String label, String? value, {bool? isHeader, bool? isTotal}) {
    return TableRow(
        decoration: isHeader == true ? const BoxDecoration(
          color: CommonColors.separatorLineColor,
        ) : null,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              label,
              style: isHeader == true || isTotal == true
                  ? CommonTypography.textBodyBold
                  : CommonTypography.textBody,
              textAlign: isHeader == true ? TextAlign.center : TextAlign.start,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              value.orEmpty(),
              textAlign: isHeader == true ? TextAlign.center : TextAlign.end,
              style: isHeader == true
                  ? CommonTypography.textBodyBold
                  : CommonTypography.textBody,
            ),
          )
        ]);
  }
}
