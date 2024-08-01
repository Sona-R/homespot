class UnboardingContent{
  String image;
  String title;
  String description;
  UnboardingContent(
      {required this.description, required this.image, required this.title});
}

List<UnboardingContent> contents=[
  UnboardingContent(description: 'Welcomeeee\n       More than 35 times',
      image:"assets/images/onspot.jpeg" ,
      title:'Welcome' ),
  UnboardingContent(description:"Fast and easy\n     Card payment is available",
      image:"assets/images/onspot.jpeg" ,
      title:"Easy and Safe online payment"),
  UnboardingContent(description: "Workers at your\n        Doorsteps",
      image: "assets/images/onspot.jpeg",
      title: "Quick and Safe ")
];