class Suggestion {
  final String title;
  Suggestion({required this.title});
}

List<Suggestion> GetSuggestionList() {
  List<Suggestion> suggestions = [];
  suggestions.add(Suggestion(title: "Hello"));
  suggestions.add(Suggestion(title: "Bye"));
  suggestions.add(Suggestion(title: "Hollywood Movies"));
  suggestions.add(Suggestion(title: "Bollywood Movies"));
  suggestions.add(Suggestion(title: "Tollywood Movies"));
  suggestions.add(Suggestion(title: "God"));
  suggestions.add(Suggestion(title: "Tell me joke"));
  suggestions.add(Suggestion(title: "Today quote"));
  suggestions.add(Suggestion(title: "London"));
  suggestions.add(Suggestion(title: "Jaipur"));
  suggestions.add(Suggestion(title: "Punjab"));
  suggestions.add(Suggestion(title: "Mobile Development"));
  suggestions.add(Suggestion(title: "Flutter"));
  suggestions.add(Suggestion(title: "Old Movies"));
  suggestions.add(Suggestion(title: "My Self"));

  return suggestions;
}
