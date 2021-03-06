own_listing = (book) ->
  book.userid is Meteor.userId()

Template.books.categories = ->
  categories
  
Template.books.get_trusts = (book) ->
  trust.find(trusted:book.userid).count()

Template.books.index = (cat) ->
  _.indexOf(categories, cat)

Template.books.conditions = ->
  conditions

Template.books.new_book = (category) ->
  Session.get('new_book') is category

Template.books.new_match = (category) ->
  true if matches.find(userId:Meteor.userId(), category:category, watched:false).count()
  
Template.books.books = (category) ->
  books.find(category:category)

Template.books.book_count = (category) ->
  books.find(category:category).count()
  
Template.books.sending_message = (id) ->
  Session.get('sending_message') is id
  
Template.books.not_own_listing = (book) ->
  not own_listing(book)

Template.books.not_already_talking = (book) ->
  book = books.findOne(_id:book._id)
  not conversations.findOne(book:book)

Template.user_profile.get_trusts = (user) ->
  Meteor.users.find(_id: {$in:(t.userId for t in trust.find(trusted:user._id).fetch())}).count()

Template.welcome.rendered = -> 
  $('#loadingModal').modal('show')
  Tracker.autorun (c) ->
    if Session.get('ready')
      $('#loadingModal').modal('hide')
      c.stop()
        

Template.books.events
  'click #add_book': (e,t) ->
    e.preventDefault()
    if t.find("#title").value
      books.insert
        category: t.find("#category").value
        description: t.find("#description").value
        title: t.find("#title").value
        time: new Date().getTime()
        userid:  Meteor.userId()
        contact: Meteor.user().emails[0]['address']
        username: Meteor.user().username
      t.find("#title").value = ''
      t.find("#description").value = ''
      $('#new_listing').click()
      watches.find(category: t.find("#category").value).forEach (watch) ->
        Meteor.call('sendEmail', watch.contact, 'default@meteor.com', "A matching listing was posted", 'new_match')
      
  'click .contact_owner': (e,t) ->
    Session.set('sending_message', e.currentTarget.id)
  
  'click .view_books': (e,t) ->
    target = e.target.hash[1...]
    cat = categories[target]
    match = matches.find(category:cat, userId:Meteor.userId(), watched:false)
    match.forEach (match) ->
      matches.update(match._id, 
        $set:
          watched:true) 
  
  'click #send_message': (e,t) ->
    e.preventDefault()
    book = books.findOne(_id:Session.get('sending_message'))
    to = book.userid
    from = Meteor.user().emails[0]['address']
    text = t.find("#message_content").value
    userId = Meteor.userId()
    unless conversations.findOne(book:book) or own_listing(book)
      _id = conversations.insert
        users: [book.userid, userId]
        watched: [userId,]
        to: to
        from: from
        userid: userId 
        book: book
        username: Meteor.user().username
      Meteor.call('sendEmail', to, from, 'Jiao Tong Listings: someone is interested in your listing', 'new_conversation')
    Session.set('sending_message', null)
    t.find("#message_content").value = ''
    conversations.update(
      _id,
      $set:
        watched: [Meteor.userId()]
      $addToSet: 
        chats:
          sender: Meteor.userId()  
          content: text
          time: new Date().getTime()
          conversation: _id
          username: Meteor.user().username
    )
    
  'click .remove_listing': (e,t) ->
    e.preventDefault()
    books.remove(e.target.id)
    