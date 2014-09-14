Meteor.startup -> 
  Accounts.onCreateUser (options, user) ->
    user.profile =
      username:options['email'].split('@')[0]
    user


Meteor.publish "Books", -> 
  books.find()

Meteor.publish "Users", ->
  Meteor.users.find(_id: this.userId)

Meteor.publish "Conversations", ->
  conversations.find(users: this.userId)
  
Meteor.publish "Watches", ->
  watches.find(userId: this.userId)

Meteor.publish "Matches", ->
  matches.find(userId: this.userId)
  
  
True = Match.Where (x) -> 
  x is true
  
NonEmptyString = Match.Where (x) -> 
  check x, String
  x.length > 0

Meteor.methods  
  sendEmail: (to, from, subject, reason)  ->
    check [to, from, subject, reason], [NonEmptyString]
    #check Meteor.user(), True
    this.unblock
    if reason is 'new_listing'
      text = 'Please take a look on listings.meteor.com, someone responded to your listing'
    if reason is 'new_match'
      text = 'Please take a look on listings.meteor.com, a new listing corresponding to your watch list was created'
    Email.send
      to: to
      from: 'info@listings.meteor.com'
      subject: subject
      text: text



   