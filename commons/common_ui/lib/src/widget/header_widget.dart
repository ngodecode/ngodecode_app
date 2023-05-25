import 'package:flutter/material.dart';
import '../../common_style.dart';
import '../../common_resource.dart';
import '../../common_widget.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({
    this.searchHint,
    this.searchText,
    this.searchRecommendation,
    this.onSearch,
    this.actions,
    Key? key,
  }) : super(key: key);

  final String? searchHint;
  final String? searchText;
  final List<String>? searchRecommendation;
  final Function(String)? onSearch;
  final List<Widget>? actions;

  @override
  State<StatefulWidget> createState() {
    return HeaderWidgetState();
  }
}
class HeaderWidgetState extends State<HeaderWidget> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 60),
        Flexible(
          flex: 1,
          child: _logo(),
        ),
        const SizedBox(width: 60),
        Flexible(
          flex: 4,
          child: _search(),
        ),
        const SizedBox(width: 60),
        Flexible(
          flex: 2,
          child: _action(),
        ),
      ],
    );
  }

  Widget _logo() {
    return Image.asset(ImageResources.iconTitle);
  }

  Widget _search() {
    final items = widget.searchRecommendation;
    return Column(
      children: [
        const SizedBox(height: 12),
        SearchWidget(
          hint: widget.searchHint,
          text: widget.searchText,
          onSearch: widget.onSearch,
        ),
        const SizedBox(height: 8),
        if (items != null)
          SizedBox(
            height: 38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return InkWell(
                  onTap: () => widget.onSearch?.call(item),
                  child: HoverWidget(
                    builder: (hovered) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          item,
                          style: hovered
                              ? CommonTypography.textButtonLink
                              : CommonTypography.textButton,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _action() {
    final items = widget.actions;
    if (items != null) {
      return SizedBox(
        height: 38,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: items[index],
          ),
          itemCount: items.length,
          reverse: true,
        ),
      );
    }
    return const SizedBox();
  }
}
