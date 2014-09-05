Meteor.startup ->
  Session.setDefault('current_category', categories[0])
  Session.setDefault('new_book', false)
  Session.set('categories', categories)
  Session.set('view_watch', false)
  Meteor.subscribe("Books")
  Meteor.subscribe("Conversations")
  Meteor.subscribe("Chats")
  Meteor.subscribe("Watches") 
  Meteor.subscribe("Matches")  
  
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
        if watches.findOne(category:book.category, userId:Meteor.userId())
          unless Meteor.userId() is book.userid
            matches.insert
              userId: Meteor.userId()
              category: book.category
              watched: false