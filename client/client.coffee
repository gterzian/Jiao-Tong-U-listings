Meteor.subscribe("Books")
Meteor.subscribe("Conversations")
Meteor.subscribe("Chats")
Meteor.subscribe("Watches")

categories = ["Beginner 1 - 初一", "Beginner 2 - 初二", "Beginner 3 - 初三", 
              "Intermediate 1 - 中一", "Intermediate 2 - 中二", "Intermediate 3 - 中三",
               "Advanced 1 - 高一", "Advanced 2 - 高二", "Advanced 3 - 高三"]
conditions = ['Like new', 'OK', 'Could be better']
               
Session.setDefault('current_category', categories[0])
Session.set('categories', categories)
Session.set('view_watch', false)

Template.conversations.conversations = ->
  conversations.find()

Template.conversations.chatting = (id) ->
  Session.get('chatting') is id

Template.navbar.categories = ->
  categories

Template.books.categories = ->
  categories

Template.books.conditions = ->
  conditions

Template.watches.categories = ->
  categories

Template.watches.conditions = ->
  conditions
  
Template.watches.watches = ->
  watches.find()
  
Template.books.current_category = ->
  Session.get('current_category')
  
Template.books.books = ->
  books.find({category:Session.get('current_category')})

Template.books.sending_message = (id) ->
  Session.get('sending_message') is id
  
Template.watches.events
  'click #add_watch': (e,t) ->
    e.preventDefault()
    unless watches.findOne(condition:t.find("#condition").value, category: t.find("#category").value)
      watches.insert
        condition: t.find("#condition").value
        category: t.find("#category").value
        userid:  Meteor.userId()
        contact: Meteor.user().emails[0]['address']
        
  'click .remove_watch': (e,t) ->
    e.preventDefault()
    console.log(e.currentTarget.id)
    watches.remove e.currentTarget.id
  
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


Template.navbar.events
  'click .choose_category': (e,t) ->
    e.preventDefault()
    Session.set('current_category', _.find(categories, (category) -> category is e.currentTarget.id))

Template.books.events
  'click #add_book': (e,t) ->
    e.preventDefault()
    if t.find("#title").value
      books.insert
        condition: t.find("#condition").value
        category: t.find("#category").value
        price: t.find("#price").value
        title: t.find("#title").value
        time: new Date().getTime()
        userid:  Meteor.userId()
        contact: Meteor.user().emails[0]['address']
      t.find("#title").value = ''
      t.find("#price").value = ''
      
  'click .contact_owner': (e,t) ->
    Session.set('sending_message', e.currentTarget.id)
  
  'click .accordion': (e,t) ->
    Session.set('sending_message', null)
  
  'click #send_message': (e,t) ->
    e.preventDefault()
    
    to = books.findOne(_id:Session.get('sending_message')).contact
    from = Meteor.user().emails[0]['address']
    text = t.find("#message_content").value
    userId = Meteor.userId()
    book = books.findOne(_id:Session.get('sending_message'))
    
    unless conversations.findOne(book:book)
      conversations.insert
        to: to
        from: from
        text: text
        userid: userId 
        book: book
      Meteor.call('sendEmail', to, from, 'Hi, I would like to buy your book', text)
    Session.set('sending_message', null)
    t.find("#message_content").value = ''