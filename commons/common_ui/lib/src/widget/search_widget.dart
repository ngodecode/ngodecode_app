import 'package:common_ui/common_style.dart';
import 'package:common_ui/nullable_extension.dart';
import 'package:flutter/material.dart';

const defaultSearchHeight = 38.0;

class SearchWidget extends StatefulWidget {
  const SearchWidget({
    this.hint,
    this.text,
    this.height,
    this.width,
    this.onSearch,
    Key? key,
  }) : super(key: key);

  final String? hint;
  final String? text;
  final double? height;
  final double? width;
  final Function(String)? onSearch;

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = widget.height ?? defaultSearchHeight;
    final cornerRadius = height / 2.5;
    final contentPadding = height / 2.5;

    controller.text = widget.text.orEmpty();

    return Container(
      height: height,
      decoration: CommonDecorations.boxOutlined(
        radius: cornerRadius,
        color: CommonColors.white,
        borderColor: CommonColors.borderLineColorNormal,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: Row(
          children: [
            SizedBox(width: contentPadding),
            Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                  hintText: widget.hint,
                  border: InputBorder.none,
                  hintStyle: CommonTypography.textLight,
                ),
                style: CommonTypography.textBody,
                maxLines: 1,
                controller: controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (action) => widget.onSearch?.call(controller.text),
              ),
            ),
            SizedBox(width: contentPadding),
            Container(
              width: height,
              height: height,
              color: CommonColors.borderLineColorNormal,
              child: InkWell(
                child: const Icon(
                  Icons.search,
                  color: CommonColors.textBodyColor,
                ),
                onTap: () => widget.onSearch?.call(controller.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
