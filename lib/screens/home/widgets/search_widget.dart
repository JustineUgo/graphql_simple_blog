import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_blog/theme/theme.dart';

class Search extends StatefulWidget {
  final Function(String) onQuery;
  const Search({
    super.key,
    required this.onQuery,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextField(
        key: const Key('search-text-field'),
        style: context.textStyle,
        controller: _searchController,
        // onSubmitted: (term) {
        //   widget.onQuery(term);
        //   _searchController.clear();
        //   setState(() => isSearching = false);
        // },
        onChanged: (query) {
          if (!isSearching && _searchController.text.isNotEmpty) {
            setState(() => isSearching = true);
          } else if (isSearching && _searchController.text.isEmpty) {
            setState(() => isSearching = false);
          }

          widget.onQuery(query);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(4),
          hintText: 'Type and press enter to search',
          hintStyle: context.textStyle.copyWith(fontSize: 12, color: Colors.white30, fontWeight: FontWeight.w600),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(24),
          ),
          prefixIcon: GestureDetector(
              onTap: !isSearching
                  ? null
                  : () {
                      _searchController.clear();
                      setState(() => isSearching = false);
                      widget.onQuery('');
                    },
              child: Icon(isSearching ? Icons.close : CupertinoIcons.search, color: Colors.white30)),
        ),
      ),
    );
  }
}
