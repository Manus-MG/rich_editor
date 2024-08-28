import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rich_editor/src/utils/javascript_executor_base.dart';
import 'package:rich_editor/src/widgets/check_dialog.dart';
import 'package:rich_editor/src/widgets/fonts_dialog.dart';
import 'package:rich_editor/src/widgets/insert_image_dialog.dart';
import 'package:rich_editor/src/widgets/insert_link_dialog.dart';
import 'package:rich_editor/src/widgets/tab_button.dart';

import 'color_picker_dialog.dart';
import 'font_size_dialog.dart';
import 'heading_dialog.dart';

class EditorToolBar extends StatelessWidget {
  final Function(File image)? getImageUrl;
  final Function(File video)? getVideoUrl;
  final JavascriptExecutorBase javascriptExecutor;
  final bool? enableVideo;

  EditorToolBar({
    this.getImageUrl,
    this.getVideoUrl,
    required this.javascriptExecutor,
    this.enableVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.0,
      child: Column(
        children: [
          Flexible(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                TabButton(
                  tooltip: 'Bold',
                  icon: Icons.format_bold,
                  onTap: () async {
                    await javascriptExecutor.setBold();
                  },
                ),
                TabButton(
                  tooltip: 'Italic',
                  icon: Icons.format_italic,
                  onTap: () async {
                    await javascriptExecutor.setItalic();
                  },
                ),
                
                TabButton(
                  tooltip: 'Underline',
                  icon: Icons.format_underline,
                  onTap: () async {
                    await javascriptExecutor.setUnderline();
                  },
                ),
                TabButton(
                  tooltip: 'Insert Link',
                  icon: Icons.link,
                  onTap: () async {
                    var link = await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return InsertLinkDialog();
                      },
                    );
                    if (link != null)
                      await javascriptExecutor.insertLink(link[0], link[1]);
                  },
                ),
                TabButton(
                  tooltip: 'Bullet List',
                  icon: Icons.format_list_bulleted,
                  onTap: () async {
                    await javascriptExecutor.insertBulletList();
                  },
                ),
        
                /// TODO: Implement Search feature
                // TabButton(
                //   tooltip: 'Search',
                //   icon: Icons.search,
                //   onTap: () async {
                //     // await javascriptExecutor.insertNumberedList();
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
