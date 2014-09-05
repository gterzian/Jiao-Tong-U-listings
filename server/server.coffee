Meteor.startup -> 


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
  sendEmail: (to, from, subject, text)  ->
    check [to, from, subject, text], [NonEmptyString]
    #check Meteor.user(), True
    this.unblock
    Email.send
      to: to
      from: from
      subject: subject
      text: text



   