import 'package:common_ui/common_style.dart';
import 'package:common_ui/common_text.dart';
import 'package:common_ui/common_widget.dart';
import 'package:common_ui/screen_extension.dart';
import 'package:flutter/material.dart';

class PurchaseMethodDialog extends StatefulWidget {
  final Future<void> Function(String email) onInstantBuy;
  final Future<void> Function() onSaveToAccount;
  final Function() onDismiss;

  const PurchaseMethodDialog({
    super.key,
    required this.onInstantBuy,
    required this.onSaveToAccount,
    required this.onDismiss,
  });

  @override
  State<StatefulWidget> createState() => _PurchaseMethodDialogState();
}

enum PurchaseMethod { instant, saveToAccount }

class _PurchaseMethodDialogState extends State<PurchaseMethodDialog> {
  PurchaseMethod? _selectedMethod;
  String? _emailErrorText;
  bool isSubmitting = false;

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
    return SizedBox(
      height: context.matchHeight(percent: 0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Purchase Method",
                style: CommonTypography.textHeading,
              ),
              InkWell(
                onTap: widget.onDismiss,
                child: const Icon(
                  Icons.close,
                  color: CommonColors.textBodyColor,
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          const DividerLineSeparator(),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Radio(
                      value: PurchaseMethod.instant,
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
                        SizedBox(
                          height: 32,
                          width: 250,
                          child: TextField(
                            decoration: CommonDecorations.inputField(
                              hint: "Type your email here",
                              errorText: _emailErrorText,
                            ),
                            style: CommonTypography.textBody,
                            enabled: _selectedMethod == PurchaseMethod.instant,
                            controller: _textEmailController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: Radio(
                      value: PurchaseMethod.saveToAccount,
                      groupValue: _selectedMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value;
                        });
                      },
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
              ),
            ),
          ),
          const DividerLineSeparator(),
          const SizedBox(height: 24),
          TextButtonFilled.primary(
            "Next",
            enabled: _selectedMethod != null && !isSubmitting,
            onPressed: () async {
              if (_selectedMethod == PurchaseMethod.instant) {
                final email = _textEmailController.text;
                if (!email.isValidEmail()) {
                  setState(() {
                    _emailErrorText = "Please input valid email address";
                  });
                  return;
                }
                setState(() {
                  isSubmitting = true;
                });
                await widget.onInstantBuy(email);
                widget.onDismiss();
              } else if (_selectedMethod == PurchaseMethod.saveToAccount) {
                setState(() {
                  isSubmitting = true;
                });
                await widget.onSaveToAccount();
                widget.onDismiss();
              }
            },
          ),
        ],
      ),
    );
  }
}
