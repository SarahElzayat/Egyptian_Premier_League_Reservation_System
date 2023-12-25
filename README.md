# DB design

we will use postgress

- to run the DB you need 2 commands

# docker pull postgres

# docker run --name postgress -e POSTGRES_PASSWORD=mysecretpassword -d postgres

- admins
- users
- stadiums
- team
- matches
- reservations

# 1-admin

has only

- username "unique"
- password
- has no signup page , only login page and iw will be through deffrentet url

# 2-users

- status: approved or not
- role: manager or fan
- username : 'unique'
- password
- email address
- first name
- last name
- birth of data
- gender
- city
- address "optional" default is none
- regesterAt

# 3-stadiums

- id : 'unique' , autoincrement
- name , string
- location
- dimension , integer
- dimension2 , integer

# 4-team

Note: there is only 18 team in the DB "from document"

- id "unique" , autoincrement
- name, string

# 5-matches

- id "unique"
- Home Team. , will be foregen key to team table
- Away Team. should not be the same as the home
  team. , will be foregen key to team table
- Match Venue (One of the stadiums approved by the EFA managers) , will be foregen key to stadium table
- Date .
- Time
- Main Referee.
- Linesmen1.
- Linesmen2.

# 6- reservation

- id "unique"
- match id "foregen key to matches"
- userId "foregen key to users"
- seat row , integer
- seat coloum , integer
