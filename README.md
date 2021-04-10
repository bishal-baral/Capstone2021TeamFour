# README
**heroku link**: https://peaceful-tor-26333.herokuapp.com/

	•	Ruby version: 2.7.2
	•	Rails version: 6.1.3
	•	Bundler version: 2.1.4
  
## To run this app, you would need to install the following:
* Install homebrew
	* '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
* Install rbenv
 	* 'brew install rbenv'
* Install Ruby
	* 'rbenv install 2.7.2'
	* 'rbenv global 2.7.2 (set this version to global)'
* Install Rails
     	* gem install rails
* Install Bundler
	* 'gem install bundler -v 2.1.4'
* Go into the app directory and run,
	* 'bundle install'
* Install yarn
	* 'brew install yarn'
* Since the app uses postgresql,
	* 'brew install postgresql'
* Installing the simple form gem
  * 'rails generate simple_form:install --bootstrap'
* After installing all the above, run
	* 'rake db:create && rake db:schema:load'
	* 'rails server' and run it on the local server.

## Functionalities:
		•	Post your review for medias like Movies, Youtube, Games etc. 
		•	Add friends, get recommendations and look at friend reviews
		•	Create events and invite friends to watch-parties where you could screen share, chat and video-chat.
		•	Search for friend reviews on medias(like Movies, Sports), titles(like Spiderman, Football) and tags like (Action, Comedy).

## PAPER PROTOTYPE:
	https://drive.google.com/file/d/1kAMbcARXaXgGn0ZymGUXxLOKftl4Kged/view?usp=sharing


## The URL Patterns are as follows:

	Home page: /

	User urls:
	Signup: /signup
	Display user's feed: /home,
	Show user's profile: /profile 
	Show user's friends' profiles: /friend_profile

	Event urls: 
	Show events: /events
	Create events: /create_event
	Display the event while attending: /event_screen

	Review urls: 
	Create reveiws: /create_review,
	Add a tag to the review: /add_tag/:id

	Session urls:
	Login: /login 
	Logout: /logout

	Friendship urls:
	Display all the friends and requests and allow search: /friendship
	Display the results of the search: /result



## Below is the schema, written following simple schema format.

	Tables:

	Name: Users
	Columns: string username, string password_digest, string email, integer code, index [username, code] uniqueness foreign_key friendship sent_by_id, sent_to_id

	Name: Events
	Columns: integer user_id, string stream_link, datetime scheduled time, string title

	Name: Invitees
	Columns: integer user_id, integer event_id

	Name: Friendships
	Columns: bigint sent_to_id, bigint sent_by_id, boolean status, index [sent_by_id, sent_to_id] uniqueness

	Name: ReviewTags
	Columns: integer review_id, integer tag_id

	Name: Reviews
	Columns: string media, string content, integer user_id, datetime post_date boolean recommended 

	Name: Tags
	Columns: string category, string name, 


	Associations:
		User -> friend_sent
		User -> friend_request
		User -> friends
		User -> pending_requests
		User -> received_requests
		User -> Reviews
		User -> Invitees
		Tag -> ReviewTag
		Review -> ReviewTag
		Review -> Tags through ReviewTags
		Event -> Invitees


## Gems, API, libraries

		Gems used:
		'rails', '~> 6.1.3'
		'sass-rails', '>= 6'
		'webpacker', '~> 5.0'
		'turbolinks', '~> 5'
		'jbuilder', '~> 2.7'
		'redis', '~> 4.0'
		'bcrypt', '~> 3.1.7'
		'image_processing', '~> 1.2'
		'bootstrap-sass', '3.4.1'
		'bootsnap', '>= 1.4.4'
		'faker'
		'pg'
		'simple_form'
		'bootstrap-datepicker-rails'
		'byebug'
		'dotenv-rails'
		'opentok'

		We are using Vonage API through opentok gem to implement our screensharing functionality.

