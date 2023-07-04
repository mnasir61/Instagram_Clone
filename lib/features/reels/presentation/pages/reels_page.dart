import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_clone/features/global/widgets/profile_widget.dart';

class ReelsPage extends StatelessWidget {
  ReelsPage({Key? key}) : super(key: key);

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ]),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.black,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView.builder(
        itemCount: 2,
        controller: PageController(initialPage: 0, viewportFraction: 1),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.purple.withOpacity(.1),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Reels",
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                        Icon(CupertinoIcons.camera)
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: profileWidget(
                                            imageUrl: "assets/local/default_profile.png"),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Text(
                                      "Username",
                                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(width: 1, color: Colors.black)),
                                      child: Text(
                                        "Follow",
                                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                  "Caption",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4,),
                                Container(
                                  width: MediaQuery.of(context).size.width*.5,
                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        CupertinoIcons.music_note_2,
                                        size: 15,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 5,),
                                      Expanded(
                                        child: Container(
                                          child: Text(
                                            "songName here",
                                            maxLines: null,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                          margin: EdgeInsets.only(top: size.height / 2.75),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.favorite_outline,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "10k",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.comment,
                                    size: 22,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(height: 7),
                                  Text(
                                    "12k",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      CupertinoIcons.paperplane,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 7),
                                  Text(
                                    "990",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      CupertinoIcons.ellipsis_vertical,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(width: 1,color: Colors.black),
                                        image: DecorationImage(
                                          image: AssetImage("assets/local/instagram_post.png"),fit: BoxFit.cover,
                                        )
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
