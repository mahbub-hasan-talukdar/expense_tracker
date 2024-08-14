import 'package:expense_tracker/domain/entity/item_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleItem extends StatelessWidget {
  const SingleItem({
    super.key,
    required this.screenWidth,
    required this.context,
    required this.items,
    required this.index,
  });

  final double screenWidth;
  final BuildContext context;
  final List<ItemEntity> items;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: _myListTile(context),
    );
  }

  ListTile _myListTile(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16),
      leading: _itemLeadingIcon(context),
      title: _itemTittle(context),
      subtitle: _itemSubtittle(context),
      trailing: _itemTrailingIcon(context),
      onTap: () {},
    );
  }

  Icon _itemTrailingIcon(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  Text _itemSubtittle(BuildContext context) {
    return Text(
      'Total expense \$${items[index].price}',
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Text _itemTittle(BuildContext context) {
    String today = DateFormat('d MMM, yyyy').format(DateTime.now());
    String currentDay = items[index].date;
    return Text(
      (currentDay == today) ? 'Today' : items[index].date,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Container _itemLeadingIcon(BuildContext context) {
    return Container(
      height: screenWidth * .10,
      width: screenWidth * .10,
      decoration: _myDecoration(context),
      child: _itemIcon(context),
    );
  }

  Icon _itemIcon(BuildContext context) {
    return Icon(
      Icons.account_balance_wallet,
      color: Theme.of(context).colorScheme.surface,
    );
  }

  BoxDecoration _myDecoration(BuildContext context) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Theme.of(context).colorScheme.primary.withOpacity(1),
          Theme.of(context).colorScheme.primary.withOpacity(.7),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shape: BoxShape.circle,
    );
  }
}
