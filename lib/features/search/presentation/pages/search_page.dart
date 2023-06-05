import 'package:flutter/material.dart';
import 'package:instagram_clone/features/global/styles/style.dart';
import 'package:instagram_clone/features/search/presentation/pages/widgets/search_field_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.colorWhite,
        elevation: 0,
        title: SearchFieldWidget(controller: _searchController),
      ),
      backgroundColor: Styles.colorWhite,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
              itemCount: 12,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width * 45,
                  decoration: BoxDecoration(color: Colors.grey),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
