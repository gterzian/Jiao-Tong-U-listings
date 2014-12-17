

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
    chat.username

Template.conversations.get_other = (conversation) ->
  if conversation.userid is Meteor.userId()
    Meteor.users.find(_id: conversation.book.userid)
  else
    Meteor.users.find(_id: conversation.userid)
    
Template.conversations.all_users = ->
  console.log(user) for user in Meteor.users.find().fetch()

Template.conversations.trust_other = (other)->
  trust.findOne(trusted:other._id, userId:Meteor.userId())
  
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
            username: Meteor.user().username
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
  
  'click .trust_other': (e,t) ->
    user_id = e.target.id
    unless trust.findOne(userId:Meteor.userId())
      _id = trust.insert
        trusted: user_id
        userId: Meteor.userId()
  
  'click .cancel_trust': (e,t) ->
    user_id = e.target.id
    to_cancel = trust.findOne(trusted: user_id,userId:Meteor.userId())._id
    console.log(to_cancel)
    trust.remove(to_cancel)
  