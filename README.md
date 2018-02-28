# GearLocker
### (In Development)

During my time at the University of Connecticut, I identified a need for an online rental management solution for the Outing Club.  Their current method for keeping track of rental gear is using paper forms, which are often inaccurate or misplaced, and the result is frequently lost and damaged gear. 

This web-application seeks to authenticate authorized rental gear managers and allow them to rent gear to club members and track all inventory using a PostgreSQL database integrated with a Ruby on Rails based web-application. A number of features including email notifications, club dues payment processing, and rental history are all features that I hope to incorporate as I continue to develop the app. 

Finally, I hope to recruit current club members to continue to contribute to the development and upkeep of the site such that it continue to help the club many years into the future. 


## Current Status

The GearLocker web application is still in the development stage and is not yet deployed for public access. It is currently set up locally with a PostgreSQL database and is successfully listing gear inventory and members, as well as having the ability to check in/out items. 

## Proposed Upgrades
 
 - Authorization with Devise/CanCanCan
 - Email notifications
 - Frontend Design
 - Item image upload/hosting (AWS S3)
 - Deployment to Heroku
 - Member dues processing/expiration


### Current Issues to Be Solved

The app utilizes the filterrific gem to enable AJAX searching and sorting of gear items and members. Unfortunately, querying the database with "DISTINCT" conflicts with the filterrific queries, and breaks the application. I am currently looking for a solution or workaround to avoid displaying duplicate entries in the items lists. 




## Authors

* **Peter Brandon** - [Github](https://github.com/pkb4112)



## License

This project is licensed under the MIT License 


