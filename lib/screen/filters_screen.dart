import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';

  final Function saveFilter;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilter);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String subtitle, bool currentValue,
      Function onChangeHandler) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: (newValue) => onChangeHandler(newValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust jour meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals',
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                      final selectedFilters = {
                        'gluten': _glutenFree,
                        'vegetarian': _vegetarian,
                        'vegan': _vegan,
                        'lactose': _lactoseFree,
                      };
                      widget.saveFilter(selectedFilters);
                    });
                  },
                ),
                _buildSwitchListTile(
                    'Vegetarian', 'Only include vegetarian meals', _vegetarian,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                    final selectedFilters = {
                      'gluten': _glutenFree,
                      'vegetarian': _vegetarian,
                      'vegan': _vegan,
                      'lactose': _lactoseFree,
                    };
                    widget.saveFilter(selectedFilters);
                  });
                }),
                _buildSwitchListTile(
                    'Vegan', 'Only include vegan meals', _vegan, (newValue) {
                  setState(() {
                    _vegan = newValue;
                    final selectedFilters = {
                      'gluten': _glutenFree,
                      'vegetarian': _vegetarian,
                      'vegan': _vegan,
                      'lactose': _lactoseFree,
                    };
                    widget.saveFilter(selectedFilters);
                  });
                }),
                _buildSwitchListTile(
                    'Lactose-free',
                    'Only include lactose-free meals',
                    _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                    final selectedFilters = {
                      'gluten': _glutenFree,
                      'vegetarian': _vegetarian,
                      'vegan': _vegan,
                      'lactose': _lactoseFree,
                    };
                    widget.saveFilter(selectedFilters);
                  });
                }),
                // IconButton(
                //   onPressed: null,
                //   icon: Icon(Icons.save),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
