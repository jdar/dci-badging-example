DCI Example (Toy Project)
====

Idea:
A ‘Code School’ badging app where any user can give any other user badges for … say… learning about DCI. Which makes recipient eligible for subsequent badge demonstrating knowledge about DCI.


Use-case summary:
Users may 'add' each other as peers, and recognize each other with badges. Some badges are associated with points (can be given repeately) while others are achievements (can only be given once).


The app uses the Data Context Interaction (DCI) paradigm in the active code. I think. I'm trying, anyway.

Note that I don't have multiple contexts yet. The DCI paradime is much more meaningful if you might use a different algorithm (as implemented by a Context class) in certain situations.


Presentation
---- 

This example codebase accompanies the August 19th presentation of Darius Roberts

https://docs.google.com/presentation/d/1YiRbB87FjQHJ56m1w2mAF4VTMXSffR6uOCIQkvY1svA/edit?usp=sharing


Running the app
----

Have tempered Expectations; This app is merely 'Death Star' operational.

There is 1 cucumber test and 1 data-import test (see test/scripts).

This project is set up to use foreman, and run on port 8000. The app should support 

```
  bundle
  cp config/database.yml.sample config/database.yml
  # ^^ postgres for sample. Ensure running. Configure to use another relational db or mongo instead.

  rake db:create
  rake db:migrate
  foreman start
```

Testing
----

Integration-level tests exist. (see features/)

```
  #requires db have been created, as per instructions in 'up and running'
  bundle exec rake cucumber
```


Quick-host on Heroku
----
  
Assuming heroku toolbelt has been installed
```
  heroku create
  #... add pg
  #... 
```

Other DCI examples
----

Idea based on [http://dci-in-ruby.info/](http://dci-in-ruby.info/)


NOT IMPLEMENTED
----

I ideated some additional features that will probably not make it into any working version of the toy. I'm listing them here because I think they would be neat.

* Group prediction
** Dynamically popup which user(s) are canditates for recognition based on... predicate of action, immediate history, or request metadata (including history?), or observed social media meta data.
* Recognition prediction
** same as above, but reversed: recommend recognition based on initiation of an action on user(s)
* Do something with earned points?


