Meteor.startup ->
  Session.setDefault('current_category', categories[0])
  Session.setDefault('new_book', false)
  Session.set('categories', categories)
  Session.set('view_watch', false)
  Meteor.subscribe("Books")
  Meteor.subscribe("Conversations")
  Meteor.subscribe("Chats")
  Meteor.subscribe("Watches")  
  
  do -> 
    query = conversations.find(users: Meteor.userId())
    handle = query.observeChanges
      added: (id, conversation) ->
        unless Meteor.userId() in conversation.watched
          conversation.watched = _.without(conversation.watched, Meteor.userId())
      changed: (id, conversation) ->
        unless Meteor.userId() in conversation.watched
          conversation.watched = _.without(conversation.watched, Meteor.userId())
        
  do -> 
    query = books.find()
    handle = query.observeChanges
      added: (id, book) ->
        unless book.userid is Meteor.userId()
          Session.set('new_book', book.category)
          if watches.findOne(userid:Meteor.userId(), condition:book.condition, category:book.category)
            Session.set('new_match', book.category)
     
  