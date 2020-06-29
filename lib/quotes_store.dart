import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:vegan_daily_quote/preferences.dart';

class QuotesStore extends GetxController {
  static QuotesStore get to => Get.find<QuotesStore>();

  // Observable variables.
  var _day = 0.obs; // Current day of the year.
  var _favorites = [].obs; // Integer list with favorite quotes.

  int _max = _quotes.indexWhere((e) => e['quote'] == ''); // Find max quotes (until we have 366...).
  
  String get quote => _quotes[_day.value]['quote'];
  String get credits => _quotes[_day.value]['credits'];
  String get link => _quotes[_day.value]['link'];
  bool get isFavorite => _favorites.value.contains(_day.value);

  QuotesStore() {
    getPreferences();
    _day.value = int.parse(DateFormat("D").format(DateTime.now())) % _max;
  }

  QuotesStore.random() {
    getPreferences();
    random();
  }

  void savePreferences() {
    List<String> favList = _favorites.map((i) => i.toString()).toList(); // Convert  int to string list.
    Preferences.to.favorites = favList;
  }

  void getPreferences() {
    List<String> savedStrList = Preferences.to.favorites;
    _favorites.value = savedStrList.map((i)=> int.parse(i)).toSet().toList(); // Also remove any duplicates.    
  }

  void set(int newDay) {
    if (newDay > 0 && newDay <= _max) _day.value = newDay;
  }

  void random() {
    _day.value = new Random().nextInt(_max + 1) % _max;
  }

  void next() {
    if (_day.value < _max) {
      _day.value += 1;
    } else {
      _day.value = 0;
    }
  }

  void prev() {
    if (_day.value > 0) {
      _day.value -= 1;
    } else {
      _day.value = _max - 1;
    }
  }

  void toggleFavorite() {
    if (_favorites.contains(_day.value)) {
      _favorites.remove(_day.value); 
    } else {
      _favorites.add(_day.value);       
    }
    savePreferences();
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
          "quote": "There is no fundamental difference between man and animals in their ability to feel pleasure and pain, happiness, and misery.",
          "credits": "Charles Darwin",
          "link": "https://blogs.uoregon.edu/rschoefff16gateway/"
      },  
      {
          "quote": "I hold that the more helpless a creature, the more entitled it is to protection by man from the cruelty of man.",
          "credits": "Mahātmā Mohandas Gandhi",
          "link": "https://en.wikipedia.org/wiki/Mahatma_Gandhi"
      },
      {
          "quote": "I think; therefore I’m vegan.",
          "credits": "Unknown",
          "link": ""
      },
      {
          "quote": "I am a firm believer in eating a full plant-based, whole food diet that can expand your life length and make you an all-around happier person. It is tricky dining out, but I just stick to what I know – veggies, fruit and salad – then when I get home I’ll have something else.",
          "credits": "Ariana Grande",
          "link": "https://www.mindbodygreen.com/0-16785/ariana-grande-explains-why-shes-vegan.html"
      },
      {
          "quote": "Going vegetarian – and then vegan – has calmed me down, and it has also made me physically and emotionally strong. I do crave meat once in a while, but I find that spiritually, non-vegetarian food works against my emotional health.",
          "credits": "Kangana Ranaut",
          "link": "https://www.quotespace.org/quotes/Going-vegetarian-a/325472"
      },
      {
          "quote": "It’s my firm intention to whop cancer into submission and I truly believe I’ve given myself the best start possible by radically overhauling my diet and by staying true to my motto, which is: Don’t worry, be happy, feel good. The first thing I did when I was diagnosed was to turn vegan.",
          "credits": "Larry Hagman",
          "link": "https://www.dailymail.co.uk/tvshowbiz/article-2083738/Dallas-legend-Larry-Hagman-tells-fighting-cancer--turning-vegan-nut.html"
      },
      {
          "quote": "My refusing to eat meat occasioned inconveniency, and I have been frequently chided for my singularity. But my light repast allows for greater progress, for greater clearness of head and quicker comprehension.",
          "credits": "Benjamin Franklin",
          "link": "https://www.relicsworld.com/benjamin-franklin/my-refusing-to-eat-meat-occasioned-inconveniency-and-i-have-been-frequently-author-benjamin-franklin"
      },
      {
          "quote": "Animals are my friends, and I don't eat my friends.",
          "credits": "George Bernard Shaw",
          "link": "https://www.veganbanana.com/vegan-meme-animals-are-my-friends-and-i-dont-eat-my-friends/"
      },
      {
          "quote": "Just as one wants happiness and fears pain, just as one wants to live and not to die, so do other creatures.",
          "credits": "The Dalai Lama XIV",
          "link": "http://www.humanedecisions.com/dalai-lama-said-life-is-dear-for-all-creatures/"
      },
      {
          "quote": "Being vegan helped me realize I can say and do what I believe is right. That’s powerful.",
          "credits": "Alicia Silverstone",
          "link": "https://www.self.com/story/alicia-silverstone-son-vegan"
      },
      {
          "quote": "People don’t think about how each of these animals that we call dinner have the same kinds of personalities as our dogs and cats.",
          "credits": "Emily Deschanel",
          "link": "https://www.livekindly.co/emily-deschanel-reveals-all-about-vegan-parenting/"
      },
      {
          "quote": "Anyone who cares about the Earth – really cares – must stop eating animals.",
          "credits": "Linda McCartney",
          "link": "https://www.vice.com/en_uk/article/ev3e57/how-linda-mccartneys-legacy-lives-on-in-the-modern-vegan-movement"
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
      {
          "quote": "",
          "credits": "",
          "link": ""
      },
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