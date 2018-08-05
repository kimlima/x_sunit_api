# x_sunit_api
Challenge for Backend Internship at Gocase

[Problem which this project plans to solve](https://github.com/kimlima/gocase-backend-challenge-internship) 

# Approaches for solving the requirements:
* Add survivors to the database

You have access to all methods of the CRUD.

OBS: Create and update doesn't affect *Localization* and the property *abducted*. Both of these have their own ways/methods.

* A survivor must have a name, age, gender and last location (latitude, longitude).

Using a table of Survivor, where every survivor has:  
 ```sh
  { id: Integer,
    name: String,
    age: Integer,
    gender: String,
    abducted: Boolean },
 ```
  And has one instance of Localization, wich represents the last location required, which has:
 ```sh 
  { id: Integer,
    survivor_id: Integer,
    latitude: Float,
    longitude: Float },
 ```
  and it's linked with only one Survivor, by *survivor_id*.
  
* Update survivor location

Having access the Id of the Survivor which the Localization is linked, you can update it.
*OBS: Only has the read and the update methods of the CRUD, all the others seemed pointless.*

* Flag survivor as abducted

It fires whenever a Survivor has 2 Witnesses linked with his Id, and a third Witness is going to link to it.
   A Witness has the Id of the Survivor who witnessed and belongs to only one other Survivor(The one who the abduction is being witnessed)
OBS: Survivors can't witness for themselves.
     A Survivor can only witness one time for each other Survivor.
     It checks if the Id being used of the witness belongs to a Survivor.
OBS: It could be interesting if only a Survivor not abducted could be a witness.

* The API must offer the following reports:

The simplest option would be to get the index of the Survivors and, in one pass, count the ones with the abducted property true, false and store these values on *abducted_quantity* and *non_abducted_quantity*, respectively. After that I could sums these two value together to get the *survivors_quantity*, then would be easy to get the percentage. But that costs O(n), and that is not very fast in the alienpocalypse. 

* Percentage of abducted survivors.
* Percentage of non-abducted survivors.
  
So, using Report as a support, I could store and change 2 values which would be enough to determine the percentages. That's how it works:
  1. Every time a Survivor it's added, the property *survivors_quantity* is implemented;
  2. Every time a Survivor is abducted, the property *abducted_quantity* is implemented;
  3. Every time a Survivor abducted is deleted, these 2 properties are decremented;
  4. Every time a Survivor non-abducted is deleted, *survivors_quantity* is decremented;

In this way, I could get these two percentages, with O(1) time. At the cost of making these methods slightly more complexes. But, as the properties sizes doesn't grow too much, these updates could be considered O(1) too. 

* List of all survivors names, by alphabetic order, with an identification to know who was abducted.

In this one, I just call *Survivor.order('name ASC')*, then I use the *name* and the *abducted* to print a list of:
```sh
  { name: 'Any Name',
    flag: [X] or [ ] }.
``` 
The cost of this one is unknow to me, as I don't know which algorithm is used is this method.

One of the ideas I had in the beggining, was that, by sacrificing the cost of create and update of the Survivor table, I could make this
report be O(n). This is what i though:
The create and update methods probably cost O(1) because of their ids. It's fairly simple to know where are the object you want to change or where do you want do store one you created. But if this list in alphabetic order is much more important, you could sacrifice these times, changing them for O(log n), using binary search and positioning them in the result. Basically, a Insertion Sort.
  
Note that this option is only viable if the List report is many times more important than these other requests. And if you have enough 
space available, you could get one ordered by ids, an another ordered by names, the later would observe the changes of the former and make these changes in 'another thread'. Kind of making possible both of these fast requests, but a the cost of double the space, and a little more time in the background.

The thing is, I didn't find a way to make these changes, so I was faded to use the method which I don't know the cost.

# My thoughs on the challenge

Really liked the theme and the ideas. Sure I could have done much better, but my inexperience with Ruby and Ruby on Rails delayed me quite a bit. Maybe the code got a bit bigger or verbose in some methods, all of this propably made me do commits a little chunked together. The references helped me a lot, one of the books really got me to try TDD, but I had some problems with the compatibility of the gems they were using, and was losing a lot of time in the beggining, I decided to stop and making without it.

Overall, even with these problems, I became quite proud of what I have done. Really liked the challenge and am happy I got to do this challenge. So, even if I don't pass in this phase, thank you for the opportunity.