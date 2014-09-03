Template.conversations.conversations = ->
  conversations.find()

Template.conversations.chatting = (id) ->
  Session.get('chatting') is id
  

Template.conversations.events
  'click #send_chat': (e, t) ->
    e.preventDefault()
    if t.find("#content").value
      conversations.update(
        Session.get('chatting'),
        $addToSet: 
          chats:  
            content: t.find("#content").value
            time: new Date().getTime()
            conversation: Session.get('chatting')
      )
      t.find("#content").value = ''
    
  'click .accordion': (e, t) ->
    Session.set('chatting', e.target.hash[1...])