class HomeListModel {
  final String title;
  final String subTitle;
  final String image;
  final String bottomLikeTitle;

  HomeListModel({required this.title, required this.subTitle, required this.image, required this.bottomLikeTitle});
}

List<HomeListModel> homeListModel = [
  HomeListModel(
      title: "Post Title 1",
      subTitle: "subTitle 1",
      image: "https://images.pexels.com/photos/672657/pexels-photo-672657.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      bottomLikeTitle: "Liked by Sanjay Gangwar, Sk and 5,331 others"),
  HomeListModel(
      title: "Post Title 2",
      subTitle: "subTitle 2",
      image: "https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg?cs=srgb&dl=pexels-pixabay-60597.jpg&fm=jpg",
      bottomLikeTitle: "Liked by Sanjay Gangwar, Sk and 5,331 others"),
  HomeListModel(
      title: "Post Title 3",
      subTitle: "subTitle 3 ",
      image: "https://images.pexels.com/photos/933054/pexels-photo-933054.jpeg?cs=srgb&dl=pexels-joyston-judah-933054.jpg&fm=jpg",
      bottomLikeTitle: "Liked by Sanjay Gangwar, Sk and 5,331 others"),
  HomeListModel(
      title: "Post Title 4 ",
      subTitle: "subTitle 4 ",
      image: "https://images.theconversation.com/files/443350/original/file-20220131-15-1ndq1m6.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C3354%2C2464&q=45&auto=format&w=926&fit=clip",
      bottomLikeTitle: "Liked by Sanjay Gangwar, Sk and 5,331 others"),
];
