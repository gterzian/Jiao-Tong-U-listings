Template.books.categories = ->
  categories

Template.books.conditions = ->
  conditions
  
Template.books.current_category = ->
  Session.get('current_category')
  
Template.books.books = ->
  books.find({category:Session.get('current_category')})

Template.books.sending_message = (id) ->
  Session.get('sending_message') is id

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