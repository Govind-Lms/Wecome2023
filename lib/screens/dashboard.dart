import 'package:flutter/material.dart';
import 'package:welcome2023/screens/listView.dart';
import 'package:welcome2023/widgets/category.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      //   title: const Text(
      //     'Fresher Welcome',
      // style:
      //     TextStyle(color: Colors.black, fontFamily: 'DIN', fontSize: 30.0),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(
      //         Icons.person,
      //         color: Colors.black,
      //       ),
      //     ),
      //     const SizedBox(
      //       width: 20.0,
      //     )
      //   ],
      // ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Fresher Welcome',
                    style: TextStyle(
                        color: Colors.black, fontFamily: 'DIN', fontSize: 30.0),
                  ),
                  const Spacer(),
                  Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(3, 3),
                              blurRadius: 6.0,
                              color: Colors.black12)
                        ]),
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.person)),
                  ),
                  const SizedBox(
                    width: 20.0,
                  )
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Category(
                    width: MediaQuery.of(context).size.width / 4 + 20,
                    height: MediaQuery.of(context).size.width / 4 + 20,
                    color: const Color(0xff64C0F4),
                    name: 'KINGS',
                    image: 'assets/images/fresherKing.png',
                    onPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ListViewScreen(
                              name: 'KINGS',
                              image: 'assets/images/fresherking.png')));
                    },
                  ),
                  Category(
                    width: MediaQuery.of(context).size.width / 4 + 20,
                    height: MediaQuery.of(context).size.width / 4 + 20,
                    color: const Color(0xffD4DCE6),
                    name: 'QUEENS',
                    image: 'assets/images/fresherQueen.png',
                    onPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ListViewScreen(
                              name: 'QUEENS',
                              image: 'assets/images/ipconfig.png')));
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Category(
                    width: MediaQuery.of(context).size.width / 4 + 20,
                    height: MediaQuery.of(context).size.width / 4 + 20,
                    color: const Color(0xff90DFAA),
                    name: 'SMART KING',
                    image: 'assets/images/smartking.png',
                    onPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ListViewScreen(
                              name: 'SMART KINGS',
                              image: 'assets/images/smartking.png')));
                    },
                  ),
                  Category(
                    width: MediaQuery.of(context).size.width / 4 + 20,
                    height: MediaQuery.of(context).size.width / 4 + 20,
                    color: const Color(0xff5DDDD3),
                    name: 'SMART QUEEN',
                    image: 'assets/images/smartqueen.png',
                    onPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const ListViewScreen(
                              name: 'SMART QUEEN',
                              image: 'assets/images/smartqueen.png')));
                    },
                  ),
                ],
              ),
              Category(
                height: 150.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                name: 'BEST COUPLE',
                image: 'assets/images/couple.png',
                onPress: () {},
              ),
              // const SizedBox(
              //   height: 100.0,
              // ),
              const Center(
                child: Text(
                  'designedBy: GovindDev',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Brush', fontSize: 18.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
