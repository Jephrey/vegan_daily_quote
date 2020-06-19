import 'package:intl/intl.dart';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class QuotesStore {

  final _favList = 'favList';

  int _day;
  int _max = _quotes.indexWhere((e) => e['quote'] == '') + 1;
  List<int> _favorites;

  Map<String, String> get quote => _quotes[_day];

  void savePreferences() async {
    List<String> strList = _favorites.map((i) => i.toString()).toList();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_favList, strList);
  }

  void getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedStrList = prefs.getStringList(_favList);
    if (savedStrList == null) {
      _favorites = [];
    } else {
      _favorites = savedStrList.map((i)=> int.parse(i)).toList();
    }
  }

  void init() {
    getPreferences();
  }

  QuotesStore() {
    _day = int.parse(DateFormat("D").format(DateTime.now())) % _max;
    init();
  }

  QuotesStore.random() {
    random();
    init();
  }

  void set(int day) {
    if (day > 0 && day < _max) _day = day;
  }

  void random() {
    _day = new Random().nextInt(_max) % _max;
  }

  void next() {
    if (_day < _quotes.length) {
      _day += 1;
    }    
  }

  void prev() {
    if (_day > 0) {
      _day -= 1;
    }
  }

  void toggleFavorite() {
    if (_favorites.contains(_day)) {
      _favorites.remove(_day); 
    } else {
      _favorites.add(_day);       
    }
    savePreferences();
  }

  bool isFavorite() {
    if (_favorites == null) return false;
    return _favorites.contains(_day);
  }

  void addToFavorites() {
    if (!_favorites.contains(_day)) _favorites.add(_day);
  }

  void removeFromFavorites() {
    _favorites.remove(_day);
  }

  static const _quotes = const
    [
      {
          "quote": "No animal needs to die in order for me to live. And that makes me feel good.",
          "credits": "Howard Lyman",
          "link": "https://quotefancy.com/quote/1648199/Howard-Lyman-No-animal-needs-to-die-in-order-for-me-to-live-And-that-makes-me-feel-good"
      },
      {
          "quote": "My body will not be a tomb for other creatures.",
          "credits": "Leonardo da Vinci",
          "link": "https://meatyourfuture.com/2019/04/leonardodavinci/"
      },
      {
          "quote": "If a kid ever realized what was involved in factory farming, they would never touch meat again.",
          "credits": "James Cromwell ",
          "link": "http://veganposters.com/if-kid-ever-realized-what-was"
      },
      {
          "quote": "Until he extends his circle of compassion to include all living things, man will not himself find peace.",
          "credits": "Albert Schweitzer",
          "link": "https://www.goodnewsnetwork.org/albert-schweitzer-quote-on-how-to-attain-peace/"
      },
      {
          "quote": "It takes nothing away from a human to be kind to an animal.",
          "credits": "Joaquin Phoenix",
          "link": "https://mercyforanimals.org/13-inspiring-celebrity-quotes-on-why-veganism"
      },
      {
          "quote": "A man can live and be healthy without killing animals for food; therefore, if he eats meat, he participates in taking animal life merely for the sake of his appetite. And to act so is immoral.",
          "credits": "Leo Tolstoy",
          "link": "https://www.humanedecisions.com/leo-tolstoy-believed-killing-and-eating-animals-is-against-the-human-heart/"
      },
      {
          "quote": "We don't need to eat anyone who would run, swim, or fly away if he could.",
          "credits": "James Cromwell",
          "link": "http://www.quotehd.com/quotes/james-cromwell-we-dont-need-to-eat-anyone-who-would-run-swim-or-fly-away-if-he"
      },
      {
          "quote": "Not to hurt our humble brethren is our first duty to them, but to stop there is not enough. We have a higher mission - to be of service to them whenever they require it.",
          "credits": "Francis of Assisi",
          "link": "https://www.humanedecisions.com/st-francis-of-assisi-said-not-to-hurt-our-humble-brethren-is-our-first-duty-to-them/"
      },
      {
          "quote": "Veganism is not a sacrifice. It is a joy.",
          "credits": "Gary L. Francione",
          "link": "http://my-face-is-on-fire.blogspot.com/2012/08/veganism-is-not-sacrifice.html"
      },
      {
          "quote": "I personally chose to go vegan because I educated myself on factory farming and cruelty to animals, and I suddenly realized that what was on my plate were living things, with feelings. And I just couldn’t disconnect myself from it any longer.",
          "credits": "Ellen DeGeneres",
          "link": "https://www.peta.org/blog/ellen-went-vegan/"
      },
      {
          "quote": "Veganism is a way of living which seeks to exclude, as far as is possible and practicable, all forms of exploitation of, and cruelty to, animals for food, clothing or any other purpose.",
          "credits": "The Vegan Society",
          "link": "https://www.vegansociety.com/go-vegan/definition-veganism"
      },
      {
          "quote": "People don’t think about how each of these animals that we call dinner have the same kinds of personalities as our dogs and cats.",
          "credits": "Emily Deschanel",
          "link": "https://en.wikipedia.org/wiki/Emily_Deschanel"
      },
      {
          "quote": "I hold that the more helpless a creature, the more entitled it is to protection by man from the cruelty of man.",
          "credits": "Mahātmā Mohandas Gandhi",
          "link": "https://en.wikipedia.org/wiki/Mahatma_Gandhi"
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      }
  ];

}