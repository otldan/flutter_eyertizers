import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model;
  final Widget child;
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Function(T) onModelInit; //初始化数据
  const ProviderWidget(
      {Key key,
      @required this.model,
      this.child,
      @required this.builder,
      this.onModelInit})
      : super(key: key);

  @override
  _ProviderWidgetState createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  T model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    if (widget.onModelInit != null && model != null) {
      widget.onModelInit(model);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (_) => model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
