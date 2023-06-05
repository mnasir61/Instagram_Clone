import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/styles/style.dart';

class ShareShowBottomModelSheetWidgetData extends StatefulWidget {
  final TextEditingController? messageController;
  final TextEditingController? searchController;

  const ShareShowBottomModelSheetWidgetData({Key? key, this.messageController, this.searchController})
      : super(key: key);

  @override
  State<ShareShowBottomModelSheetWidgetData> createState() =>
      _ShareShowBottomModelSheetWidgetDataState();
}

class _ShareShowBottomModelSheetWidgetDataState extends State<ShareShowBottomModelSheetWidgetData> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      _messageField(),
                      verticalSize(10),
                      _searchField(),
                      verticalSize(15),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset("assets/local/default_profile.png"),
                                  ),
                                  horizontalSize(10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "John Doe",
                                        style: Styles.titleLine2.copyWith(
                                            color: Styles.colorBlack, fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        "rahim_jani007",
                                        style: Styles.titleLine2.copyWith(color: Styles.colorWhiteMid),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              _sendButtonWidget(),
                            ],
                          ),
                          verticalSize(15),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _messageField() {
    return TextFormField(
      controller: widget.messageController,
      decoration: InputDecoration(
        hintText: "Write a message...",
        border: InputBorder.none,
      ),
    );
  }

  _searchField() {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: widget.searchController,
        decoration: InputDecoration(
          hintText: "Search",
          suffixIcon: Icon(
            FontAwesomeIcons.userPlus,
            size: 18,
          ),
          prefixIcon: Icon(
            FontAwesomeIcons.search,
            size: 18,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  _sendButtonWidget() {
    return Container(
      height: 30,
      width: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      child: Center(
        child: Text(
          "Send",
          style: Styles.titleLine1.copyWith(fontSize: 16),
        ),
      ),
    );
  }
}
