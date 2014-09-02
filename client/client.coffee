Meteor.subscribe("Books")

categories = ["Beginner 1 - 初一", "Beginner 2 - 初二", "Beginner 3 - 初三", 
              "Intermediate 1 - 中一", "Intermediate 2 - 中二", "Intermediate 3 - 中三",
               "Advanced 1 - 高一", "Advanced 2 - 高二", "Advanced 3 - 高三"]
conditions = ['Very Good', 'OK', 'Could be better']
               
Session.setDefault('current_category', categories[0])
Session.set('categories', categories)

Template.navbar.categories = ->
  categories

Template.navbar.events
  'click .choose_category': (e,t) ->
    Session.set('current_category', _.find(categories, (category) -> category is e.currentTarget.id))

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
    Meteor.call 'sendEmail', books.findOne(_id:Session.get('sending_message')).contact,  Meteor.user().emails[0]['address'] ,'I would like to buy your book', t.find("#message_content").value
    Session.set('sending_message', null)