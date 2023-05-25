import 'package:common_di/common_di.dart';
import 'package:common_ui/common_bloc.dart';
import 'package:common_ui/common_resource.dart';
import 'package:common_ui/common_style.dart';
import 'package:common_ui/common_text.dart';
import 'package:common_ui/common_widget.dart';
import 'package:common_ui/nullable_extension.dart';
import 'package:common_ui/screen_extension.dart';
import 'package:common_ui/number_extension.dart';
import 'package:flutter/material.dart';
import 'package:payment_ui/src/bloc/payment_bloc.dart';
import 'package:payment_ui/src/bloc/payment_event.dart';
import 'package:payment_ui/src/bloc/payment_state.dart';

class PaymentDialog extends StatefulWidget {
  const PaymentDialog({
    super.key,
    required this.productId,
    required this.variantId,
    this.onDismiss,
    this.productName,
    this.imageUrl,
    this.price,
    this.variantName,
    this.tax,
  });

  final Function()? onDismiss;
  final int productId;
  final int variantId;
  final String? productName;
  final String? imageUrl;
  final String? variantName;
  final double? price;
  final double? tax;

  @override
  State<StatefulWidget> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> with Injectable {
  String? _emailErrorText;
  PaymentMethod? _selectedMethod;

  final TextEditingController _textEmailController = TextEditingController();

  @override
  void initState() {
    _textEmailController.addListener(() {
      if (_emailErrorText != null) {
        setState(() {
          _emailErrorText = null;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentBloc(
        inject(),
        inject(),
        productId: widget.productId,
        variantId: widget.variantId,
      ),
      child: AlertDialog(
        content: _buildWidget(),
      ),
    );
  }

  Widget _buildWidget() {
    return SizedBox(
      height: context.matchHeight(percent: 0.5),
      width: context.matchWidth(percent: 0.4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _header(),
          const SizedBox(height: 16),
          const DividerLineSeparator(),
          const SizedBox(height: 16),
          BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              return Expanded(
                child: SingleChildScrollView(
                  child: state.isPageMethod()
                      ? _selectMethodOptions()
                      : state.isPageConfirm()
                          ? _orderConfirmation(state.email.orEmpty())
                          : _orderCompleted(state.email.orEmpty()),
                ),
              );
            },
          ),
          const DividerLineSeparator(),
          const SizedBox(height: 24),
          _button(),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<PaymentBloc, PaymentState>(builder: (context, state) {
          return Text(
            state.isPageMethod()
                ? "Payment Method"
                : state.isPageConfirm()
                    ? "Order Confirmation"
                    : "Order Completed",
            style: CommonTypography.textHeading,
          );
        }),
        InkWell(
          onTap: widget.onDismiss,
          child: const Icon(
            Icons.close,
            color: CommonColors.textBodyColor,
          ),
        )
      ],
    );
  }

  Widget _selectMethodOptions() {
    return Column(
      children: [
        ListTile(
          leading: Radio(
            value: PaymentMethod.instant,
            groupValue: _selectedMethod,
            onChanged: (value) {
              setState(() {
                _selectedMethod = value;
              });
            },
          ),
          title: const Text(
            "Instant Buy",
            style: CommonTypography.textBodyBold,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "No need to sign in or sign up, after payment success we will sent the download link to your email.",
                style: CommonTypography.textBody,
              ),
              const SizedBox(height: 8),
              if (_selectedMethod == PaymentMethod.instant)
                SizedBox(
                  height: _emailErrorText == null ? 38 : 60,
                  width: 250,
                  child: TextField(
                    decoration: CommonDecorations.inputField(
                      hint: "Type your email here",
                      errorText: _emailErrorText,
                    ),
                    style: CommonTypography.textBody,
                    controller: _textEmailController,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ListTile(
          leading: Radio(
            fillColor: const MaterialStatePropertyAll(
              CommonColors.buttonDisabledColor,
            ),
            value: PaymentMethod.saveToAccount,
            groupValue: _selectedMethod,
            onChanged: null,
          ),
          title: const Text(
            "Save to my account",
            style: CommonTypography.textBodyBold,
          ),
          subtitle: const Text(
            "Need to signed in, after payment success you can download the file from your gallery on profile menu.",
            style: CommonTypography.textBody,
          ),
        )
      ],
    );
  }

  Widget _orderCompleted(String email) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageResources.illustrationEmailSent,
            width: 300,
            height: 175,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: CommonTypography.textBody,
              children: [
                const TextSpan(
                  text: "Invoice and download link has been sent to ",
                ),
                TextSpan(
                  text: email,
                  style: CommonTypography.textBodyBold,
                ),
                const TextSpan(
                  text: ".\nPlease make sure you have access to your email.",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderConfirmation(String email) {
    final total = widget.tax.orZero() + widget.price.orZero();
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(1),
                color: CommonColors.imageBackground,
                child: Image.network(
                  widget.imageUrl.orEmpty(),
                ),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 250,
              child: Text(
                "${widget.productName.orEmpty()} "
                "${widget.variantName.isNullOrEmpty() ? "" : " - ${widget.variantName.orEmpty()}"}",
                style: CommonTypography.textBody,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                widget.price.toIDR(),
                style: CommonTypography.textBody,
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        Row(children: [
          const SizedBox(width: 140),
          const Text(
            "Tax",
            style: CommonTypography.textBody,
          ),
          Expanded(
            child: Text(
              widget.tax.toIDR(),
              style: CommonTypography.textBody,
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(width: 20),
        ]),
        const SizedBox(height: 16),
        Row(
          children: const [
            SizedBox(width: 140),
            Expanded(child: DividerLineSeparator()),
            SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const SizedBox(width: 140),
            const Text(
              "Total",
              style: CommonTypography.textBody,
            ),
            Expanded(
              child: Text(
                total.toIDR(),
                style: CommonTypography.textBodyBold,
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        const SizedBox(height: 32),
        RichText(
          text: TextSpan(
            style: CommonTypography.textBody,
            children: [
              const TextSpan(
                text: "We will sent invoice and download link to ",
              ),
              TextSpan(
                text: email,
                style: CommonTypography.textBodyBold,
              ),
              const TextSpan(
                text: ".\nPlease make sure you have access to your email.",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _button() {
    return BlocBuilder<PaymentBloc, PaymentState>(builder: (context, state) {
      return TextButtonFilled.primary(
        state.isPageMethod()
            ? "Next"
            : state.isPageConfirm()
                ? "Confirm"
                : "Ok",
        onPressed: () => _next(context, state),
        loading: state.isSubmitting.orFalse(),
      );
    });
  }

  void _next(BuildContext context, PaymentState state) {
    if (state.isPageMethod()) {
      final method = _selectedMethod;
      final email = _textEmailController.text;

      if (!email.isValidEmail()) {
        setState(() {
          _emailErrorText = "Please input valid email address";
        });
        return;
      }

      if (method != null && email.isNotEmpty) {
        context
            .read<PaymentBloc>()
            .add(SelectPaymentMethod(method: method, email: email));
      }
    } else if (state.isPageConfirm()) {
      context.read<PaymentBloc>().add(
            SubmitInstantPay(
              productId: state.productId,
              variantId: state.variantId,
              email: state.email.orEmpty(),
            ),
          );
    } else {
      widget.onDismiss?.call();
    }
  }
}
