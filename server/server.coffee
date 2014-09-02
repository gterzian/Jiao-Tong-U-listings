Meteor.startup -> 

Meteor.publish "Books", -> 
  books.find()

Meteor.publish "Users", ->
  Meteor.users.find(_id: this.userId)
  
True = Match.Where (x) -> 
  x is true


Meteor.methods  
  sendEmail: (to, from, subject, text)  ->
    console.log [to, from, subject, text]
    check([to, from, subject, text], [String])
   
    check from is Meteor.user().emails[0]['address'], True
    
    this.unblock
    Email.send
      to: to
      from: from
      subject: subject
      text: text