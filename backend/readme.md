# DB design

we will use postgress

- to run the DB you need 2 commands

# docker pull postgres

# docker run --name postgress -e POSTGRES_PASSWORD=mysecretpassword -d postgres

- admins
- users
- statiums
- team
- matches
- reservations

# 1-admin

has only

- username "unique"
- password
- has no signup page , only login page and iw will be through deffrentet url

# 2-users

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

# 3-statiums

- id : 'unique'
- name
- dimntion1
- dimentsion2

# 4-team

Note: there is only 18 team in the DB "from document"

- id "unique"
- name

# 5-matches

- id "unique"
- Home Team. , will be foregen key
- Away Team. should not be the same as the home
  team). , will be foregen key
- Match Venue (One of the stadiums approved by the EFA managers) , will be foregen key
- Date & Time.
- Main Referee.
- Two Linesmen.

# 6- reservations

- id "unique"
- matches id "foregen key to matches"
- user "foregen key to users"
- seat row
- seat coloum
