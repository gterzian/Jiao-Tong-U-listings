Meteor.startup -> 

Meteor.publish "Books", -> 
  books.find()

Meteor.publish "Users", ->
  Meteor.users.find(_id: this.userId)

Meteor.publish "Conversations", ->
  conversations.find(userid: this.userId)
  
True = Match.Where (x) -> 
  x is true
  
NonEmptyString = Match.Where (x) -> 
  check x, String
  x.length > 0

Meteor.methods  
  sendEmail: (to, from, subject, text)  ->
    console.log [to, from, subject, text]
    check [to, from, subject, text], [NonEmptyString]
    check from is Meteor.user().emails[0]['address'], True
    this.unblock
    Email.send
      to: to
      from: from
      subject: subject
      text: text
   