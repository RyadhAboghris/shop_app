import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';
import 'package:shop_app/shared/components/componenets.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultformfield(
                        conttroller: SearchController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'enter text to search';
                          }
                          return null;
                        },
                        onSubmit: (String text) {
                          SearchCubit.get(context).search(text);
                        },
                        lable: 'Search',
                        prefx: Icons.search,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      if (state is SearchSuccessState)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              buildListProduct(
                                // SearchCubit.get(context).model.data.data[index],
                                context,
                                isOldPrice: false,
                              );
                            },
                            separatorBuilder: (context, index) => Divider(),
                            itemCount: 10,
                            // itemCount: SearchCubit.get(context).model.data.data.length,
                          ),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
