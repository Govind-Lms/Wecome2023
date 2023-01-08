// import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:welcome2023/models/candidate.dart';
import 'package:welcome2023/screens/dashboard.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({super.key, required this.name, required this.image});
  final String name;
  final String image;

  @override
  State<ListViewScreen> createState() => ListViewScreenState();
}

class ListViewScreenState extends State<ListViewScreen>
    with SingleTickerProviderStateMixin {
  late List<CandidateModel> candidateLists = [];
  late AnimationController _animationController;
  late List<String> imageLists;
  late List<String> kingImages = [
    'assets/participants/kings/1.jpg',
    'assets/participants/kings/2.jpg',
    'assets/participants/kings/3.jpg',
    'assets/participants/kings/4.jpg',
    'assets/participants/kings/5.jpg',
    'assets/participants/kings/6.jpg',
    'assets/participants/kings/7.jpg',
    'assets/participants/kings/8.jpg',
    'assets/participants/kings/9.jpg',
    'assets/participants/kings/10.jpg',
    'assets/participants/kings/11.jpg',
    'assets/participants/kings/12.jpg',
    'assets/participants/kings/13.jpg',
    'assets/participants/kings/14.jpg',
    'assets/participants/kings/15.jpg',
    'assets/participants/kings/16.jpg',
    'assets/participants/kings/17.jpg',
    'assets/participants/kings/18.jpg',
    'assets/participants/kings/19.jpg',
  ];
  late List<String> queenImages = [
    'assets/participants/queens/1.jpg',
    'assets/participants/queens/2.jpg',
    'assets/participants/queens/3.jpg',
    'assets/participants/queens/4.jpg',
    'assets/participants/queens/5.jpg',
    'assets/participants/queens/6.jpg',
    'assets/participants/queens/7.jpg',
    'assets/participants/queens/8.jpg',
    'assets/participants/queens/9.jpg',
    'assets/participants/queens/10.jpg',
    'assets/participants/queens/11.jpg',
    'assets/participants/queens/12.jpg',
    'assets/participants/queens/13.jpg',
    'assets/participants/queens/14.jpg',
    'assets/participants/queens/15.jpg',
    'assets/participants/queens/16.jpg',
    'assets/participants/queens/17.jpg',
    'assets/participants/queens/18.jpg',
    'assets/participants/queens/19.jpg',
  ];

  late List<String> coupleImages = [
    'assets/participants/couples/1.jpg',
    'assets/participants/couples/2.jpg',
    'assets/participants/couples/3.jpg',
    'assets/participants/couples/4.jpg',
    'assets/participants/couples/5.jpg',
    'assets/participants/couples/6.jpg',
    'assets/participants/couples/7.jpg',
    'assets/participants/couples/8.jpg',
    'assets/participants/couples/9.jpg',
    'assets/participants/couples/10.jpg',
    'assets/participants/couples/11.jpg',
    'assets/participants/couples/12.jpg',
    'assets/participants/couples/13.jpg',
    'assets/participants/couples/14.jpg',
    'assets/participants/couples/15.jpg',
    'assets/participants/couples/16.jpg',
    'assets/participants/couples/17.jpg',
    'assets/participants/couples/18.jpg',
    'assets/participants/couples/19.jpg',
  ];

  double page = 0.0;

  late String name = widget.name;
  final _pageController = PageController();
  Stream kingsStream =
      FirebaseFirestore.instance.collection('Kings').snapshots();
  Stream queensStream =
      FirebaseFirestore.instance.collection('Queens').snapshots();

  CollectionReference kref = FirebaseFirestore.instance.collection('Kings');
  CollectionReference qref = FirebaseFirestore.instance.collection('Queens');

  getStream() {
    switch (name) {
      case 'KINGS':
        return kingsStream;
      case 'QUEENS':
        return queensStream;
    }
  }

  getImageLists() {
    switch (name) {
      case 'KINGS':
        // return imageLists = kingImages;
        return setState(() {
          imageLists = kingImages;
        });
      case 'QUEENS':
        // return queensStream;
        return setState(() {
          imageLists = queenImages;
        });
      case 'Couples':
        // return queensStream;
        return setState(
          () {
            imageLists = queenImages;
          },
        );
    }
  }

  getQuery() {
    switch (name) {
      case 'KINGS':
        return kref;
      case 'QUEENS':
        return qref;
    }
  }

  Future<List<CandidateModel>> fetchAllUsers() async {
    QuerySnapshot snapshot = await getQuery().orderBy("no").get();
    final candidates = snapshot.docs
        .map(
          (doc) => CandidateModel(
            age: doc['age'],
            name: doc['name'],
            no: doc['no'],
            year: doc['year'],
            image: doc['image'],
          ),
        )
        .toList();
    return candidates;
  }

  @override
  void initState() {
    fetchAllUsers().then((list) {
      getImageLists();
      candidateLists = list;
      setState(() {
        candidateLists = list;
      });
      return candidateLists;
    });
    _pageController.addListener(_listenScroll);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 1000),
    );
    super.initState();
  }

  void _listenScroll() {
    setState(() {
      page = _pageController.page!;
    });
  }

  Future<void> onTap() async {
    _animationController.forward();
    await Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, _) {
          return FadeTransition(opacity: animation, child: Container());
        }));
    _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.removeListener(_listenScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Object>>(
        stream: getStream(),
        builder: ((context, snapshot) {
          if (snapshot.hasError ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.amber,
            ));
          }
          if (snapshot.hasData) {
            return SizedBox(
              child: PageView.builder(
                controller: _pageController,
                itemCount: candidateLists.length,
                itemBuilder: (BuildContext context, int index) {
                  final percent = (page - index).abs().clamp(0.0, 1.0);
                  final scale = (page - index).abs().clamp(0.0, 0.3);

                  final opacity = percent.clamp(0.0, 0.6);

                  final lists = candidateLists[index];

                  return Transform.scale(
                    scale: 1 - scale,
                    child: Opacity(
                      opacity: (1 - opacity),
                      child: CandidateTile(
                        title: widget.name,
                        onTap: onTap,
                        year: lists.year,
                        age: lists.age,
                        name: lists.name,
                        image: imageLists[index].toString(),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('loading'));
          }
        }),
      ),
    );
  }
}

class CandidateTile extends StatelessWidget {
  const CandidateTile(
      {super.key,
      required this.onTap,
      required this.name,
      required this.age,
      required this.year,
      required this.title,
      required this.image});
  final String name;
  final String year;
  final String age;
  final String image;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    late String inputCode;
    return Stack(
      alignment: Alignment.center,
      children: [
        // CachedNetworkImage(
        //   imageUrl: image,
        //   fit: BoxFit.cover,
        //   alignment: Alignment.center,
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height,
        // ),
        Image(
          image: AssetImage(image),
          fit: BoxFit.cover,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Positioned(
          top: 30,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 60.0,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(3, 3),
                      blurRadius: 6.0,
                      blurStyle: BlurStyle.outer,
                      color: Colors.black12)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 25.0,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => const DashBoardScreen()));
                      },
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'DIN',
                      fontSize: 18.0,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10.0),
              color: Colors.teal[50]?.withOpacity(.4),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      name.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 24.0,
                          fontFamily: 'DIN'),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      year,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: 'DIN'),
                    ),
                  ],
                ),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(109.0),
                      color: Colors.teal[100]),
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0))),
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return Container(
                              height: 600.0,
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(30.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: Colors.black,
                                      ),
                                      width: 100.0,
                                      height: 5.0,
                                    ),
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(1000.0),
                                      child: Image(
                                        image: AssetImage(image),
                                        width: 150.0,
                                        height: 150.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20.0, left: 20.0, right: 20.0),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Enter Your Code'.toUpperCase(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.0),
                                      ),
                                    ),
                                    Container(
                                      height: 60.0,
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                                offset: Offset(3, 3),
                                                blurRadius: 6.0,
                                                blurStyle: BlurStyle.outer,
                                                color: Colors.black12)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.white),
                                      margin: const EdgeInsets.all(20.0),
                                      child: Center(
                                        child: TextFormField(
                                          onChanged: ((code) {
                                            inputCode = code;
                                          }),
                                          // scrollPadding:
                                          //     const EdgeInsets.all(10.0),
                                          keyboardType: TextInputType.number,
                                          decoration:
                                              const InputDecoration.collapsed(
                                                  hintText: '  Eg: 12345678'),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        width: 60.0,
                                        height: 60.0,
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(3, 3),
                                                blurRadius: 6.0,
                                                blurStyle: BlurStyle.outer,
                                                color: Colors.black12,
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(109.0),
                                            color: Colors.white),
                                        child: IconButton(
                                          icon: const Icon(
                                            Icons.favorite,
                                            color: Colors.redAccent,
                                            size: 24.0,
                                          ),
                                          onPressed: () {
                                            print(inputCode.toString());
                                            Navigator.of(context).pop(true);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    icon: const Icon(Icons.favorite),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
