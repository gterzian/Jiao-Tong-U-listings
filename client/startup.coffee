Meteor.startup ->
  
  Session.setDefault('current_category', categories[0])
  Session.setDefault('new_book', false)
  Session.set('categories', categories)
  Session.set('view_watch', false)
  Session.set('ready', false)
  Meteor.subscribe("Books", -> Session.set('ready', true))
  Meteor.subscribe("Conversations")
  Meteor.subscribe("Chats")
  Meteor.subscribe("Watches") 
  Meteor.subscribe("Matches")
  Meteor.subscribe('Users', ->
    console.log('okss')
    currentUser = Meteor.users.findOne(_id:Meteor.userId())
    Meteor.users.update(
      Meteor.userId(),
      $set:
        profile:
          logged_in: true
          )
  )
  Meteor.subscribe('Trust')
  Accounts.ui.config
    passwordSignupFields: 'USERNAME_AND_EMAIL'
    
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
  
  i18n.map 'cn', 
    Hello: '你好'
    'Join our English activities': '参加英语活动吧'
    "Activity Groups": '活动群'
    "Create a Group": "Create a Group"
    "Create": "Create"
  
  i18n.map 'en', 
    Hello: 'Hello'
    'Join our English activities': 'Join our English activities'
    'Activity Groups': 'Activity Groups'
    "Create a Group": "Create a Group"
    "Create": "Create"
    
  i18n.setLanguage('en')  
  
