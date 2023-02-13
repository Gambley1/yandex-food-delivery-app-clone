// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:papa_burger/src/restaurant.dart';
import 'package:papa_burger/src/views/pages/orders/components/test_screen.dart';

final _globalBucket = PageStorageBucket();

class OrdersView extends StatefulWidget {
  const OrdersView({
    Key? key,
  }) : super(key: key);


  @override
  State<OrdersView> createState() => _OrdersViewState();
}

@override
class _OrdersViewState extends State<OrdersView> with WidgetsBindingObserver {
  bool isSortedByData = false;
  bool isSortedByAlphabet = false;
  bool hasPermission = true;
  Map<String, String> someMoreProducts = {};
  final products = {
    'a': "2021-12-11",
    's': "2019-01-31",
    'h': "2022-09-20",
    'g': "2010-03-23",
    'b': "2006-06-09",
  };
  List<String> datestrings = [
    "2021-12-11",
    "2020-02-12",
    "2010-01-23",
    "2013-01-14",
  ];

  Timer? _timer;
  Duration _duration = const Duration(seconds: 10);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadDuration().then((duration) {
      if (!mounted) return;
      setState(() {
        _duration = duration;
        _startTimer();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _saveDuration();
    WidgetsBinding.instance.addObserver(this);
    logger.i('disposed');
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _setCountDown();
    });
  }

  void _setCountDown() {
    const reduceSeconds = 1;
    final seconds = _duration.inSeconds - reduceSeconds;
    if (seconds < 0) {
      _stopTimer();
      _removePermission();
      logger.i(seconds);
      logger.i(hasPermission);
    } else {
      if (!mounted) return;
      _duration = Duration(seconds: seconds);
      logger.i(seconds);
    }
  }

  void _stopTimer() {
    if (!mounted) return;
    setState(() {
      _timer?.cancel();
    });
    logger.i('stopped');
  }

  void _removePermission() {
    if (_timer!.isActive || _duration.inSeconds <= 0) {
      hasPermission = false;
    }
  }

  Future<void> _saveDuration() async {
    final storage = Prefs.instance;
    logger.i('saved');
    await storage.saveTimer(_duration.inSeconds);
  }

  Future<Duration> _loadDuration() async {
    final storage = Prefs.instance;
    int seconds = storage.getTimer;
    return Duration(seconds: seconds);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    WidgetsBinding.instance.removeObserver(this);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _saveDuration();
      logger.i('save duration');
      if (!mounted) return;
      _stopTimer();
    } else if (state == AppLifecycleState.resumed) {
      try {
        _loadDuration().then((duration) {
          if (!mounted) return;
          setState(() {
            _duration = duration;
            _startTimer();
          });
        });
      } catch (e) {
        logger.i(e.toString());
      }
    }
    logger.i('AppLifeCycleState $state');
  }

  @override
  Widget build(BuildContext context) {
    final int someMoreProductsLength =
        someMoreProducts.entries.map((e) => e).length;
    List<MapEntry<String, String>> keysAndValues = products.entries.toList();

    sortDataByDateTime() {
      keysAndValues.sort(
        ((a, b) => isSortedByData
            ? DateTime.parse(a.value).compareTo(
                DateTime.parse(b.value),
              )
            : DateTime.parse(b.value).compareTo(
                DateTime.parse(a.value),
              )),
      );
    }

    sortDataByAlphabet() {
      isSortedByData
          ? keysAndValues.map((e) => e.key).toList().reversed
          : keysAndValues.map((e) => e.key).toList();
    }

    return PageStorage(
      bucket: _globalBucket,
      key: const PageStorageKey<String>('Orders Page'),
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(
              12,
              42,
              12,
              0,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        final storage = Prefs.instance;
                        await storage.saveTimer(60);
                        _stopTimer();
                        setState(() {
                          hasPermission = true;
                        });
                        _startTimer();
                      },
                      child: const KText(
                        text: 'Wipe data',
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: OutlinedButton.icon(
                        clipBehavior: Clip.none,
                        label: const KText(
                          text: 'Sort by Data',
                        ),
                        icon: FaIcon(
                          isSortedByData
                              ? FontAwesomeIcons.arrowDownShortWide
                              : FontAwesomeIcons.arrowUpWideShort,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            isSortedByData = !isSortedByData;
                          });

                          sortDataByDateTime();

                          final Map<String, String> sortedMapData =
                              Map.fromEntries(keysAndValues);
                          setState(() {
                            someMoreProducts = sortedMapData;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: OutlinedButton.icon(
                        clipBehavior: Clip.none,
                        label: const KText(text: 'Sort by Alphabet'),
                        icon: FaIcon(
                          isSortedByAlphabet
                              ? FontAwesomeIcons.arrowDownAZ
                              : FontAwesomeIcons.arrowUpAZ,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            isSortedByAlphabet = !isSortedByAlphabet;
                          });

                          sortDataByAlphabet();

                          final Map<String, String> sortedMapData =
                              Map.fromEntries(keysAndValues);
                          setState(() {
                            someMoreProducts = sortedMapData;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: hasPermission,
                  replacement: const Center(
                    child: KText(
                      text: 'Permission to this data has expired.',
                      size: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final anotherItemValue = someMoreProducts.entries
                            .map((e) => e.value)
                            .toList();
                        final anotherItemKey =
                            someMoreProducts.entries.map((e) => e.key).toList();

                        final productsName =
                            products.entries.map((e) => e.value).toList();
                        final productsKey =
                            products.entries.map((e) => e.key).toList();
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              PageTransition(
                                child: const TestScreen(),
                                type: PageTransitionType.fade,
                              ),
                              (route) => true,
                            );
                          },
                          child: Card(
                            elevation: 6,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  KText(
                                    text: someMoreProductsLength != 0
                                        ? '${anotherItemKey[index]}: '
                                        : '${productsKey[index]}: ',
                                  ),
                                  KText(
                                    text: someMoreProductsLength != 0
                                        ? '${anotherItemValue[index]} '
                                        : '${productsName[index]} ',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: someMoreProductsLength == 0
                          ? products.length
                          : someMoreProductsLength,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
