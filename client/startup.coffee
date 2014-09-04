Meteor.startup ->
  query = conversations.find(users: Meteor.userId())
  handle = query.observeChanges
    added: (id, conversation) ->
      console.log(conversation.chats)
    changed: (id, conversation) ->
      Session.set('new_chat', id)