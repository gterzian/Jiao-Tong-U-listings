Meteor.subscribe("Books")

categories = ["Beginner 1 - 初一", "Beginner 2 - 初二", "Beginner 3 - 初三", 
              "Intermediate 1 - 中一", "Intermediate 2 - 中二", "Intermediate 3 - 中三",
               "Advanced 1 - 高一", "Advanced 2 - 高二", "Advanced 3 - 高三"]
               
Session.setDefault('current_category', categories[0])
Session.set('categories', categories)

Template.navbar.categories = ->
  categories

Template.navbar.events
  'click .choose_category': (e,t) ->
    Session.set('current_category', _.find(categories, (r) -> r is e.currentTarget.id))

Template.books.categories = ->
  categories
  
Template.books.current_category = ->
  Session.get('current_category')
  
Template.books.books = ->
  books.find({category:Session.get('current_category')})
  
Template.books.events
  'click #add_book': (e,t) ->
    e.preventDefault()
    if t.find("#title").value
      console.log(t.find("#category").value)
      books.insert
        category: t.find("#category").value
        title: t.find("#title").value
        time: new Date().getTime()
        userid:  Meteor.userId()
      t.find("#title").value = ''