import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:vegan_daily_quote/controllers/preferences.dart';

class QuotesController extends GetxController {
  static QuotesController get to => Get.find<QuotesController>();

  // Observable variables.
  var _day = 0.obs; // Current day of the year.
  var _favorites = [].obs; // Integer list with favorite quotes.

  int _max = _quotes.indexWhere(
      (e) => e['quote'] == ''); // Find max quotes (until we have 366...).

  String get quote => _quotes[_day.value]['quote'];
  String get credits => _quotes[_day.value]['credits'];
  String get link => _quotes[_day.value]['link'];
  String get notifcationQuote {
    quoteOfTheDay();
    return _quotes[_day.value]['credits'];
  }

  bool get isFavorite => _favorites.contains(_day.value);

  QuotesController() {
    getPreferences();
    quoteOfTheDay();
  }

  QuotesController.random() {
    getPreferences();
    random();
  }

  /// Return the quote and credits of tomorrow.
  List<String> get tomorrowsQuote {
    var _tomorrow = _day.value + 1;
    if (_tomorrow >= _max) {
      _tomorrow = 0;
    }
    var _quote = _quotes[_tomorrow]['quote'];
    var _credits = _quotes[_tomorrow]['credits'];
    return [_quote, _credits];
  }

  void quoteOfTheDay() {
    _day.value = int.parse(DateFormat("D").format(DateTime.now())) % _max;
  }

  void savePreferences() {
    PreferencesController.to.favorites = List<int>.from(_favorites);
  }

  void getPreferences() {
    _favorites.value = PreferencesController.to.favorites;
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

  static const _quotes = const [
    {
      "quote":
          "No animal needs to die in order for me to live. And that makes me feel good.",
      "credits": "Howard Lyman",
      "link":
          "https://quotefancy.com/quote/1648199/Howard-Lyman-No-animal-needs-to-die-in-order-for-me-to-live-And-that-makes-me-feel-good"
    },
    {
      "quote": "My body will not be a tomb for other creatures.",
      "credits": "Leonardo da Vinci",
      "link": "https://meatyourfuture.com/2019/04/leonardodavinci/"
    },
    {
      "quote":
          "If a kid ever realized what was involved in factory farming, they would never touch meat again.",
      "credits": "James Cromwell ",
      "link": "http://veganposters.com/if-kid-ever-realized-what-was"
    },
    {
      "quote":
          "Until he extends his circle of compassion to include all living things, man will not himself find peace.",
      "credits": "Albert Schweitzer",
      "link":
          "https://www.goodnewsnetwork.org/albert-schweitzer-quote-on-how-to-attain-peace/"
    },
    {
      "quote": "It takes nothing away from a human to be kind to an animal.",
      "credits": "Joaquin Phoenix",
      "link":
          "https://mercyforanimals.org/13-inspiring-celebrity-quotes-on-why-veganism"
    },
    {
      "quote":
          "A man can live and be healthy without killing animals for food; therefore, if he eats meat, he participates in taking animal life merely for the sake of his appetite. And to act so is immoral.",
      "credits": "Leo Tolstoy",
      "link":
          "https://www.humanedecisions.com/leo-tolstoy-believed-killing-and-eating-animals-is-against-the-human-heart/"
    },
    {
      "quote":
          "We don't need to eat anyone who would run, swim, or fly away if he could.",
      "credits": "James Cromwell",
      "link":
          "http://www.quotehd.com/quotes/james-cromwell-we-dont-need-to-eat-anyone-who-would-run-swim-or-fly-away-if-he"
    },
    {
      "quote":
          "Not to hurt our humble brethren is our first duty to them, but to stop there is not enough. We have a higher mission - to be of service to them whenever they require it.",
      "credits": "Francis of Assisi",
      "link":
          "https://www.humanedecisions.com/st-francis-of-assisi-said-not-to-hurt-our-humble-brethren-is-our-first-duty-to-them/"
    },
    {
      "quote": "Veganism is not a sacrifice. It is a joy.",
      "credits": "Gary L. Francione",
      "link":
          "http://my-face-is-on-fire.blogspot.com/2012/08/veganism-is-not-sacrifice.html"
    },
    {
      "quote":
          "I personally chose to go vegan because I educated myself on factory farming and cruelty to animals, and I suddenly realized that what was on my plate were living things, with feelings. And I just couldn’t disconnect myself from it any longer.",
      "credits": "Ellen DeGeneres",
      "link": "https://www.peta.org/blog/ellen-went-vegan/"
    },
    {
      "quote":
          "Veganism is a way of living which seeks to exclude, as far as is possible and practicable, all forms of exploitation of, and cruelty to, animals for food, clothing or any other purpose.",
      "credits": "The Vegan Society",
      "link": "https://www.vegansociety.com/go-vegan/definition-veganism"
    },
    {
      "quote":
          "There is no fundamental difference between man and animals in their ability to feel pleasure and pain, happiness, and misery.",
      "credits": "Charles Darwin",
      "link": "https://blogs.uoregon.edu/rschoefff16gateway/"
    },
    {
      "quote":
          "I hold that the more helpless a creature, the more entitled it is to protection by man from the cruelty of man.",
      "credits": "Mahātmā Mohandas Gandhi",
      "link": "https://en.wikipedia.org/wiki/Mahatma_Gandhi"
    },
    {
      "quote": "I think; therefore I’m vegan.",
      "credits": "Unknown",
      "link": ""
    },
    {
      "quote":
          "I am a firm believer in eating a full plant-based, whole food diet that can expand your life length and make you an all-around happier person. It is tricky dining out, but I just stick to what I know – veggies, fruit and salad – then when I get home I’ll have something else.",
      "credits": "Ariana Grande",
      "link":
          "https://www.mindbodygreen.com/0-16785/ariana-grande-explains-why-shes-vegan.html"
    },
    {
      "quote":
          "Going vegetarian – and then vegan – has calmed me down, and it has also made me physically and emotionally strong. I do crave meat once in a while, but I find that spiritually, non-vegetarian food works against my emotional health.",
      "credits": "Kangana Ranaut",
      "link": "https://www.quotespace.org/quotes/Going-vegetarian-a/325472"
    },
    {
      "quote":
          "It’s my firm intention to whop cancer into submission and I truly believe I’ve given myself the best start possible by radically overhauling my diet and by staying true to my motto, which is: Don’t worry, be happy, feel good. The first thing I did when I was diagnosed was to turn vegan.",
      "credits": "Larry Hagman",
      "link":
          "https://www.dailymail.co.uk/tvshowbiz/article-2083738/Dallas-legend-Larry-Hagman-tells-fighting-cancer--turning-vegan-nut.html"
    },
    {
      "quote":
          "My refusing to eat meat occasioned inconveniency, and I have been frequently chided for my singularity. But my light repast allows for greater progress, for greater clearness of head and quicker comprehension.",
      "credits": "Benjamin Franklin",
      "link":
          "https://www.relicsworld.com/benjamin-franklin/my-refusing-to-eat-meat-occasioned-inconveniency-and-i-have-been-frequently-author-benjamin-franklin"
    },
    {
      "quote": "Animals are my friends, and I don't eat my friends.",
      "credits": "George Bernard Shaw",
      "link":
          "https://www.veganbanana.com/vegan-meme-animals-are-my-friends-and-i-dont-eat-my-friends/"
    },
    {
      "quote":
          "Just as one wants happiness and fears pain, just as one wants to live and not to die, so do other creatures.",
      "credits": "The Dalai Lama XIV",
      "link":
          "http://www.humanedecisions.com/dalai-lama-said-life-is-dear-for-all-creatures/"
    },
    {
      "quote":
          "Being vegan helped me realize I can say and do what I believe is right. That’s powerful.",
      "credits": "Alicia Silverstone",
      "link": "https://www.self.com/story/alicia-silverstone-son-vegan"
    },
    {
      "quote":
          "People don’t think about how each of these animals that we call dinner have the same kinds of personalities as our dogs and cats.",
      "credits": "Emily Deschanel",
      "link":
          "https://www.livekindly.co/emily-deschanel-reveals-all-about-vegan-parenting/"
    },
    {
      "quote":
          "Anyone who cares about the Earth – really cares – must stop eating animals.",
      "credits": "Linda McCartney",
      "link":
          "https://www.vice.com/en_uk/article/ev3e57/how-linda-mccartneys-legacy-lives-on-in-the-modern-vegan-movement"
    },
    {
      "quote":
          "I look forward to the day when animals will have the right to run if they have legs, swim if they have fins, and fly if they have wings.",
      "credits": "Gretchen Wyler",
      "link": "https://en.wikipedia.org/wiki/Gretchen_Wyler"
    },
    {
      "quote":
          "Animal liberation is also human liberation. Animal liberationists care about the quality of life for all.",
      "credits": "Henry Spira",
      "link": "https://link.springer.com/chapter/10.1007/978-1-4612-5623-6_26"
    },
    {
      "quote":
          "My perspective of veganism was most affected by learning that the veal calf is a by-product of dairying, and that in essence there is a slice of veal in every glass of what I had thought was an innocuous white liquid – milk.",
      "credits": "Rynn Berry",
      "link": "https://www.all-creatures.org/aro/q-berry-rynn.html"
    },
    {
      "quote":
          "At the moment our human world is based on the suffering and destruction of millions of non-humans. To perceive this and to do something to change it in personal and public ways is to undergo a change of perception akin to a religious conversion.",
      "credits": "Sir Arthur Conan Doyle",
      "link": "https://davekjaer.com/index.php/why-vegan/vegan-luminaries/"
    },
    {
      "quote":
          "My diet is a whole food, plant based or vegan diet. So, basically I want you to eat whole grains, legumes, tonnes of vegetables and fruits, nuts and seeds. No meat whatsoever, and no processed foods. It’s amazing what it can do for your body, and it reduces your risk for chronic disease.",
      "credits": "Julieanna Hever",
      "link": "https://plantbaseddietitian.com/"
    },
    {
      "quote":
          "I made the choice to be vegan because I will not eat (or wear, or use) anything that could have an emotional response to its death or captivity. I can well imagine what that must feel like for our non-human friends – the fear, the terror, the pain – and I will not cause such suffering to a fellow living being.",
      "credits": "Rai Aren",
      "link": "https://veganismthebackground.jimdofree.com/"
    },
    {
      "quote":
          "Basically, the reason I’m vegan is because when I was about 16 or 17 years old, I began to understand that we don’t need to contribute to the killing and exploitation of animals to feed our bodies correctly.",
      "credits": "Daniel Johns",
      "link": "https://quotesground.com/authors/Daniel-Johns"
    },
    {
      "quote":
          "All children should be encouraged to love and respect animals, not turn a blind eye to their suffering and stab forks into their dead bodies.",
      "credits": "Mango Wodzak",
      "link": "http://www.fruitnut.net/about-me"
    },
    {
      "quote":
          "I am grateful to realize that my desires do not entitle me to add to another’s suffering.",
      "credits": "Zoe Weil",
      "link": "https://humaneeducation.org/who-we-are/meet-zoe-weil/"
    },
    {
      "quote":
          "If you think that being vegan is difficult, imagine being a factory farmed animal.",
      "credits": "Davegan Raza",
      "link": "https://twitter.com/veganuary/status/1159825407375491077"
    },
    {
      "quote":
          "If you really care about animals, then stop trying to figure out how to exploit them ‘compassionately’. Just stop exploiting them.",
      "credits": "Gary Francione",
      "link": "https://www.abolitionistapproach.com/about/gary-l-francione/"
    },
    {
      "quote":
          "The question is not, 'Can they reason?' nor, 'Can they talk?' but rather, 'Can they suffer?",
      "credits": "Jeremy Bentham",
      "link": "https://speakingofresearch.com/extremism-undone/ar-beliefs/"
    },
    {
      "quote":
          "The soul is the same in all living creatures, although the body of each is different.",
      "credits": "Hippocrates",
      "link": "https://thebark.com/content/soul-all-living-creatures"
    },
    {
      "quote":
          "Every person I have met who has gone vegan says it is the best decision they have ever made.",
      "credits": "Lewis Hamilton",
      "link": "https://www.brainyquote.com/quotes/lewis_hamilton_872365"
    },
    {
      "quote":
          " became a vegetarian after realizing that animals feel afraid, cold, hungry and unhappy like we do.",
      "credits": "Cesar Chavez",
      "link": "https://www.azquotes.com/quote/816227"
    },
    {
      "quote":
          "A vegan diet is probably the single biggest way to reduce your impact on planet Earth …. It is far bigger than cutting down on your flights or buying an electric car.",
      "credits": "Joseph Poore",
      "link": "https://www.ecowatch.com/vegan-earth-footprint-2574241439.html"
    },
    {
      "quote":
          "Nothing will benefit human health and increase the chances for survival of life on Earth as much as the evolution to a vegetarian diet.",
      "credits": "Albert Einstein",
      "link":
          "https://www.foodandwine.com/cooking-techniques/albert-einstein-genius-birthday-boy-vegetarian-vegan"
    },
    {
      "quote":
          "One should not kill a living being, nor cause it to be killed, nor should one incite another to kill. Do not injure any being, either strong or weak, in the world.",
      "credits": "Buddha",
      "link":
          "http://www.humanedecisions.com/buddha-said-one-should-not-kill-a-living-being/"
    },
    {
      "quote":
          "Veganism extends compassionate, gentle benevolence to all sentient beings.",
      "credits": "Stanley Sapon",
      "link": "https://ivu.org/congress/wvc96/texts/stanley.html"
    },
    {
      "quote": "Animals are not ingredients.",
      "credits": "Barbara Thompson",
      "link": "https://veganposters.com/author/barbara-thompson"
    },
    {
      "quote":
          "For as long as man continues to be the ruthless destroyer of lower living beings, he will never know health or peace. For as long as men massacre animals, they will kill each other. Indeed, he who sows the seeds of murder and pain cannot reap joy and love.",
      "credits": "Pythagoras",
      "link": "https://ivu.org/history/greece_rome/pythagoras.html"
    },
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""},
    {"quote": "", "credits": "", "link": ""}
  ];
}
