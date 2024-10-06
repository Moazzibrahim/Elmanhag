class Session {
  final String name;
  final int id;
  final String image;
  final List<Live> lives;

  Session({
    required this.name,
    required this.id,
    required this.lives,
    required this.image
  });

  factory Session.fromJson(Map<String, dynamic> json){ 
    var livesFromJson = json['live'] as List;
    List<Live> liveList = livesFromJson.map((liveJson) => Live.fromJson(liveJson)).toList();
    return Session(
        name: json['name'],
        id: json['id'],
        lives: liveList,
        image: json['thumbnail_url']
      );
  }
}

class Sessions {
  final List<dynamic> sessions;

  Sessions({required this.sessions});

  factory Sessions.fromJson(Map<String, dynamic> json) =>
      Sessions(sessions: json['sessions']);
}

class Live {
  final String name;
  final int id;
  final int subjectId;
  final String from;
  final String to;
  final String date;
  final String day;
  final String link;

  Live({
    required this.name,
    required this.id,
    required this.subjectId,
    required this.from,
    required this.to,
    required this.date,
    required this.day,
    required this.link,
  });

  factory Live.fromJson(Map<String, dynamic> json) => Live(
        name: json['name'],
        id: json['id'],
        subjectId: json['subject_id'],
        from: json['from'],
        to: json['to'],
        date: json['date'],
        day: json['day'],
        link: json['link'],
      );
}


