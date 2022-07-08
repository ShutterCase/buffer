class HomeStoriesModel {
  final String image;
  final String title;
  final String activeStories;

  HomeStoriesModel({required this.title, required this.activeStories, required this.image});
}

List<HomeStoriesModel> homeStoriesModel = [
  HomeStoriesModel(
    title: "josh",
    activeStories: "Active",
    image: "https://images.pexels.com/photos/672657/pexels-photo-672657.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  ),
  HomeStoriesModel(
    title: "Sam",
    activeStories: "notActive",
    image: "https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg?cs=srgb&dl=pexels-pixabay-60597.jpg&fm=jpg",
  ),
  HomeStoriesModel(
    title: "Becca",
    activeStories: "notActive",
    image: "https://images.pexels.com/photos/933054/pexels-photo-933054.jpeg?cs=srgb&dl=pexels-joyston-judah-933054.jpg&fm=jpg",
  ),
  HomeStoriesModel(
    title: "Stephanie",
    activeStories: "notActive",
    image: "https://images.pexels.com/photos/672657/pexels-photo-672657.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  ),
  HomeStoriesModel(
    title: "Mike",
    activeStories: "notActive",
    image: "https://images.theconversation.com/files/443350/original/file-20220131-15-1ndq1m6.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C3354%2C2464&q=45&auto=format&w=926&fit=clip",
  ),
  HomeStoriesModel(
    title: "Mark",
    activeStories: "notActive",
    image: "https://images.pexels.com/photos/672657/pexels-photo-672657.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
  ),
];
