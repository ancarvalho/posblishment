import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class Tags extends StatefulWidget {
  const Tags({super.key, this.items, required this.textfieldTagsController});
  final List<String>? items;
  final TextfieldTagsController textfieldTagsController;

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  

  @override
  Widget build(BuildContext context) {
    return TextFieldTags(
      textfieldTagsController: widget.textfieldTagsController,
      initialTags: widget.items,
      textSeparators: const [' ', ','],
      letterCase: LetterCase.normal,
      validator: (String tag) {
        if (widget.textfieldTagsController.getTags != null && widget.textfieldTagsController.getTags!.contains(tag)) {
          return 'ja existe';
        }
        return null;
      },
      inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmit) {
        return (context, sc, tags, onTagDelete) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: tec,
              focusNode: fn,
              decoration: InputDecoration(
                isDense: true,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    // color: Color.fromARGB(255, 74, 137, 92),
                    width: 3,
                  ),
                ),
                hintText: widget.textfieldTagsController.hasTags ? '' : "Insira Variação...",
                errorText: error,
                prefixIconConstraints:
                    BoxConstraints(maxWidth: Sizes.width(context) * .9),
                prefixIcon: tags.isNotEmpty
                    ? SingleChildScrollView(
                        controller: sc,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: tags.map((String tag) {
                            return Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                // color: Color.fromARGB(255, 74, 137, 92),
                              ),
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5,),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    tag,
                                  ),
                                  const SizedBox(width: 4),
                                  InkWell(
                                    child: const Icon(
                                      Icons.cancel,
                                      size: 14,
                                      // color: Color.fromARGB(255, 233, 233, 233),
                                    ),
                                    onTap: () {
                                      onTagDelete(tag);
                                    },
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    : null,
              ),
              onChanged: onChanged,
              onSubmitted: onSubmit,
            ),
          );
        };
      },
    );
  }
}
