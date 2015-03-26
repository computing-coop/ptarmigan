ptarmigan
=========

How (not?) to run an arts/culture/project space

## About

Ptarmigan was a cultural platform based in [Helsinki, Finland](http://ptarmigan.fi) (2009-present?) and [Tallinn, Estonia](http://ptarmigan.ee) (2011-2014).

This is the code that runs both Ptarmigan sites as well as several "subsites" using the same back-end CMS and database. This was started in 2009 on Rails 2.1 and slowly hacked together over the years to suit the very custom nature of a two-city non-profit project space. 

Currently, the [CreativeTerritories](http://creativeterritories.lv) site runs from the same code, which is a calendar of grassroots cultural events in Riga, Latvia actively being used. The Ptarmigan sites (both .fi and .ee) are archived as well, and some smaller one-off projects such as [Kompass](http://kompass.ptarmigan.ee), the blog of former artist-in-residence [Kimmo Modig](http://kimmomodig.ptarmigan.ee),  [Done Kino](http://donekino.ptarmigan.ee) and [Kuulutused](http://kuulutused.ptarmigan.ee).

All subsites run from a central MySQL database, with a common interface for events, artist-in-residence profiles, project profiles, and other features. The code uses Globalize to provide I18n/multi-lingual support. The appropriate site is loaded based on the domain name in the URI request, and content is scoped appropriately.

This is freely available for your use or mis-use, I guess under the MIT license. It's pretty idiosyncratic - at this point it's probably overkill for the majority of uses, but if you have something as specific as what Ptarmigan was (a trans-disciplinary culture space operating in two countries at the same time), maybe it can be of use. The CMS is rough but features some elements that may help with administration, such as a basic wiki, document uploading/cataloguing system, and primitive accounting/expenses system.

I doubt there will be much interest in the code, but feel free to get in touch if you have any questions. This was hacked at in my spare time and I'm not particularly proud of it. It's not that clean, there's a lot of residue from the earlier versions of Rails that I never properly cleaned out, and there are numerous features only half-developed.

I'd be happy to offer advice for anyone wanting to roll this out and use it; feel free to contact me (GitHub user cenotaph).


