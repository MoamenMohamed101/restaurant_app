// OnBoarding Models
class OnBoardingModel {
  String? title;
  String? description;
  String? image;

  OnBoardingModel(this.title, this.description, this.image);
}

// This model carry the data form view model to view
class OnBoardingSlidersViewObject {
  OnBoardingModel onBoardingModel;
  int numberOfSlides;
  int currentIndex;

  OnBoardingSlidersViewObject(
      this.onBoardingModel, this.numberOfSlides, this.currentIndex);
}