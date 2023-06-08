import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/features/post/presentation/cubit/post_cubit.dart';
import 'package:instagram_clone/features/search/presentation/pages/widgets/search_page_main_widget.dart';
import 'package:instagram_clone/main_injection_container.dart' as di;

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PostCubit>(
        create: (context) => di.sl<PostCubit>(),
      ),
    ], child: SearchPageMainWidget());
  }
}
