import 'package:http/http.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:saraswantiland/models/manga.dart';

class Helper {
  Client _client;

  Helper() {
    this._client = Client();
  }

  Future<List<Manga>> getAllManga() async {
    List<Manga> allManga = [];
    final response = await _client
        .get('https://www.detik.com/search/searchall?query=finance&siteid=2');
    final document = parse(response.body);
    final mangasPerTitle = document.getElementsByClassName('list-berita');
    for (Element mangaPerTitle in mangasPerTitle) {
      final mangas = mangaPerTitle.getElementsByTagName('article');
      for (Element m in mangas) {
        final aTag = m.getElementsByTagName('h2')[0];
        final urTag = m.getElementsByTagName('a')[0];
        final imgTag = m.getElementsByTagName('img')[0];
        final dateTag = m.getElementsByClassName('date')[0];
        final title = aTag.text;
        final url = urTag.attributes['href'];
        final img = imgTag.attributes['src'];
        final date = dateTag.text;
        final manga = Manga(title: title, url: url, img: img, date: date);
        allManga.add(manga);
      }
    }
    return allManga;
  }
}
