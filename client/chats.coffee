

Template.conversations.conversations = ->
  conversations.find()

Template.conversations.chatting = (id) ->
  Session.get('chatting') is id
  
Template.conversations.new_chat = (id) ->
  not _.contains(conversations.findOne(id).watched, Meteor.userId())

Template.conversations.get_user = (chat) ->
  if chat.sender is Meteor.userId()
    'you'
  else
    'the other'

  
Template.conversations.events
  'click #send_chat': (e, t) ->
    e.preventDefault()
    if t.find("#content").value
      conversations.update(
        Session.get('chatting'),
        $set:
          watched: [Meteor.userId()]
        $addToSet: 
          chats:
            sender: Meteor.userId()  
            content: t.find("#content").value
            time: new Date().getTime()
            conversation: Session.get('chatting')
      )
      t.find("#content").value = ''
    
  'click .accordion': (e, t) ->
    conversation_id = e.target.hash[1...]
    Session.set('chatting', conversation_id)
    conversations.update(conversation_id, 
      $addToSet: 
        watched: Meteor.userId()
      )
  