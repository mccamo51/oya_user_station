import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:oya_porter/spec/colors.dart';

itemTile({
  @required String carNumber,
  @required String seater,
  Function onDelete,
  bool showDele = false,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(FeatherIcons.truck),
          title: Text("$carNumber"),
          subtitle: Text("$seater Seater"),
          trailing: showDele
              ? Container(height: 0, width: 0)
              : IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: RED,
                  ),
                  onPressed: onDelete,
                ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 50.0),
        child: Divider(),
      )
    ],
  );
}

itemTileB({
  @required String carNumber,
  @required String seater,
  Function onDelete,
  Function onEdit,
}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListTile(
          leading: Icon(FeatherIcons.truck),
          title: Text("$carNumber"),
          subtitle: Text("$seater Seater"),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: PRIMARYCOLOR,
                  ),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: RED,
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 50.0),
        child: Divider(),
      )
    ],
  );
}
