import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // leading: title 위젯의 앞에 표시되는 위젯
        leading: Padding(
          // Padding을 통해 위젯 외부로 여백을 줌

          // EdgeInsets.only : 특정 방향(top, left, ...)으로만 padding을 적용할 수 있음
          // EdgeInsets.symmetric : 가로, 세로 방향으로 동일한 padding을 적용할 수 있음
          // EdgeInsets.all : 모든 방향으로 padding을 적용할 수 있음
          // EdgeInsets.fromLTRB : left, top, right, bottom 순서로 padding을 적용할 수 있음
          padding: const EdgeInsets.only(left: 20),
          // Image.asset을 통해 asset 폴더에 저장된 이미지를 불러올 수 있음
          child: Image.asset("assets/images/logo.png", color: Colors.white),
        ),
        leadingWidth: 130,

        // actions: title 위젯의 뒤에 표시되는 위젯(들)
        actions: const [
          // Icon 위젯을 통해 Material 내장 아이콘을 표시할 수 있음(노션 - 참고 자료 - Material Icons 참고)
          Icon(Icons.favorite_outline), // 아이콘 이름 뒤에 _outline를 붙이면 테두리만 있는 아이콘이 표시됨
          SizedBox(width: 20),
          Icon(Icons.send_outlined),
          SizedBox(width: 20),
        ],

        // appBar 설정
        foregroundColor: Colors.white, // AppBar 내의 텍스트 및 아이콘 색상
        backgroundColor: Colors.black, // AppBar의 배경색
      ),

      // SingleChildScrollView를 통해 스크롤 가능한 화면을 만들 수 있음
      body: SingleChildScrollView(
        // physics: 스크롤 동작 방식을 지정

        // BouncingScrollPhysics(): 스크롤이 끝에 도달했을 때 튕기는 효과(Android 느낌)
        // ClampingScrollPhysics(): 스크롤이 끝에 도달했을 때 튕기는 효과를 제거(iOS 느낌)
        // 스크롤이 중첩된 상태에서는 NeverScrollableScrollPhysics()를 사용하여 스크롤을 막을 수 있음(하단에 기술)
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            // 스토리 버튼
            SizedBox(
              // Horizontal ScrollView에선 height를 명시적으로 지정해줘야 함
              // ListView가 자동으로 높이를 계산해주지 못함...
              height: 130,
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // 가로 스크롤, 기본값은 세로 스크롤(Axis.vertical)
                shrinkWrap: true, // ListView의 크기를 자식 위젯에 맞춤
                physics: const ClampingScrollPhysics(),
                itemCount: 10, // 스토리 버튼의 개수를 임의로 10개로 지정

                // itemBuilder를 통해 ListView의 내부 위젯을 지정
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        // 위젯 외부로 여백을 줌
                        // EdgeInsets.symmetric을 통해 가로, 세로 방향으로 동일한 padding을 적용할 수 있음
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Container(
                          // Container의 크기를 지정(스토리 버튼 크기)
                          width: 100,
                          height: 100,

                          // BoxDecoration을 통해 Container의 테두리, 배경색, 모양 등을 지정할 수 있음
                          // decoration 속성을 사용하지 않고 사이즈만 변경 할 경우 SizedBox를 사용하는 것이 좋음
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3), // 테두리 색상, 두께 지정
                            color: Colors.grey, // 배경색 지정
                            shape: BoxShape.circle, // Container 모양 지정
                          ),
                        ),
                      ),
                      const SizedBox(height: 10), // SizedBox를 통해 빈 공간을 생성하여 위젯 간의 간격을 지정
                      Text("Username $index", style: const TextStyle(color: Colors.white)), // Text 위젯을 통해 텍스트를 표시
                    ],
                  );
                },
              ),
            ),

            // 게시글
            ListView.builder(
              // 최상위 Scroll이 존재하여, 하위 ListView의 Scroll을 막기 위해(스크롤이 중첩된 상태)
              // NeverScrollableScrollPhysics()를 사용하여 게시글 Scroll을 막음
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    // Column의 내부 위젯의 정렬 방식을 지정
                    // mainAxisAlignment: 세로 방향 정렬(Column의 경우 세로 방향이 정방향이므로)
                    // crossAxisAlignment: 가로 방향 정렬(Column의 경우 가로 방향이 역방향이므로)
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                "seoul.go",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Icon(Icons.more_horiz, color: Colors.white),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        "assets/images/post_image.jpg",

                        // 사진의 가로 길이를 화면의 가로 길이와 동일하게 설정
                        width: MediaQuery.of(context).size.width,
                        // 사진의 세로 길이도 화면의 가로 길이와 동일하게 설정하여 정방형 이미지로 표시
                        height: MediaQuery.of(context).size.width,

                        // BoxFit.cover: 사진의 가로, 세로 비율을 유지하면서 화면에 꽉 차게 표시
                        // BoxFit.fill: 사진의 가로, 세로 비율을 유지하지 않고 화면에 꽉 차게 표시
                        // BoxFit.fitWidth: 사진의 가로 비율을 유지하면서 화면의 가로 길이에 맞춰 표시
                        // BoxFit.fitHeight: 사진의 세로 비율을 유지하면서 화면의 세로 길이에 맞춰 표시
                        // BoxFit.scaleDown: 사진의 가로, 세로 비율을 유지하면서 화면에 꽉 차게 표시하되, 사진의 크기가 화면보다 클 경우 사진의 크기를 줄임
                        // BoxFit.none: 사진의 가로, 세로 비율을 유지하지 않고 화면에 꽉 차게 표시
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          // Column의 내부 위젯의 정렬 방식을 지정
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Icon(Icons.favorite_outline, color: Colors.white, size: 30),
                                  SizedBox(width: 10),
                                  Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 30),
                                  SizedBox(width: 10),
                                  Icon(Icons.send_outlined, color: Colors.white, size: 30),
                                  Spacer(),
                                  Icon(Icons.bookmark_outline, color: Colors.white, size: 30),
                                ],
                              ),
                            ),
                            const Text("좋아요 2,463개", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                            // RichText를 통해 텍스트의 일부분만 스타일을 변경할 수 있음,, 다음에 더 자세히 설명
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(color: Colors.white),
                                children: [
                                  TextSpan(text: "seoul.go ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: "[11월엔 서울 무조건 터질 듯 ㅎㄷㄷ🎄💖]\n조금 일찍 찾아왔다는 크리스마스와 예쁜 축제들을 만날 수 있는 11월!벌써 두근거린다,,💕@@구경하러 고고",
                                      style: TextStyle(fontWeight: FontWeight.w500)),
                                  TextSpan(text: " 더보기", style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey)),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child:
                                  Text("댓글 2,463개 모두 보기", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16)),
                            ),
                            const Text("10월 24일", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // BottomNavigationBar를 통해 하단 탭바를 표시할 수 있음
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBar의 아이콘을 클릭했을 때의 동작을 지정
        // BottomNavigationBarType.fixed: 탭바의 아이콘을 고정 크기로 표시
        // BottomNavigationBarType.shifting: 탭바의 선택된 아이콘을 크게(또는 작게) 표시
        type: BottomNavigationBarType.fixed,

        backgroundColor: Colors.black, // 탭바의 배경색
        selectedItemColor: Colors.white, // 선택된 아이콘 색상
        unselectedItemColor: Colors.white, // 선택되지 않은 아이콘 색상
        showSelectedLabels: false, // 선택된 아이콘의 라벨 표시 여부
        showUnselectedLabels: false, // 선택되지 않은 아이콘의 라벨 표시 여부
        items: const [
          // BottomNavigationBarItem을 통해 탭바에 들어갈 항목들을 지정
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'add'),
          BottomNavigationBarItem(icon: Icon(Icons.movie_creation_outlined), label: 'reels'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'profile'),
        ],
      ),
    );
  }
}
