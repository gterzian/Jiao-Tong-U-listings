

Meteor.startup -> 
  userId = null

  Meteor.publish "Books", -> 
    userId = this.userId
    books.find()

  Meteor.publish "Users", ->
    Meteor.users.find(_id: {$in:_.flatten((c.users for c in conversations.find(users: this.userId).fetch()))})

  Meteor.publish "Conversations", ->
    conversations.find(users: this.userId)
  
  Meteor.publish "Watches", ->
    watches.find(userId: this.userId)

  Meteor.publish "Matches", ->
    matches.find(userId: this.userId)
  
  Meteor.publish "Trust", ->
    trust.find()
  

  Meteor.onConnection (conn) ->
    conn.onClose ->
      currentUser = Meteor.users.findOne(_id:userId)
      Meteor.users.update(
        userId,
        $set:
          profile:
            logged_in: false
      )
      currentUser = Meteor.users.findOne(_id:userId)
      console.log(currentUser)
      console.log(userId) 

  
  
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
    if reason is 'new_conversation'
      text = 'Please take a look on listings.meteor.com, someone responded to your listing and started a chat'
    if reason is 'new_message'
      text = "Please take a look on listings.meteor.com, #{from} sent you a new message while you were offline"
    Email.send
      to: Meteor.users.findOne(_id:to).emails[0]['address']
      from: 'info@listings.meteor.com'
      subject: subject
      text: text



   