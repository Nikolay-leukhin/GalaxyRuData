import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NftCertificateScreen extends StatefulWidget {
  const NftCertificateScreen({super.key});

  @override
  State<NftCertificateScreen> createState() => _NftCertificateScreenState();
}

class _NftCertificateScreenState extends State<NftCertificateScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/auth_background.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset('assets/icons/rf.svg')
            ],
          ),
        ),
        body: const Column(
          children: [],
        ),
      ),
    );
  }
}
