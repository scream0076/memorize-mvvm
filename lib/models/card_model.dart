class CardModel {
  final String emoji;
  bool isSelected;

  CardModel({required this.emoji, this.isSelected = false});
  
  @override
  String toString() {
    return emoji + isSelected.toString() + hashCode.toString();
  }
}