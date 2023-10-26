import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sachintha_uee/utils/constants.dart';

class AddressBook extends StatelessWidget {
  final double padding;
  const AddressBook({
    super.key,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("address")
            .where(
              "address_of",
              isEqualTo: FirebaseAuth.instance.currentUser?.uid,
            )
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.data != null
              ? ListView(
                  padding: EdgeInsets.all(padding),
                  children: snapshot.data!.docs
                      .map(
                        (e) => GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white),
                            padding: const EdgeInsets.all(defaultPadding),
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${e['address_01']},${e['address_02']},${e['city']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  "Pick on map >> ",
                                  style: TextStyle(
                                    color: successColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              : const SizedBox();
        },
      ),
    );
  }
}
