Template.watches.categories = ->
  categories

Template.watches.conditions = ->
  conditions
  
Template.watches.watches = ->
  watches.find()
  
  
Template.watches.events
  'click #add_watch': (e,t) ->
    e.preventDefault()
    unless watches.findOne(category: t.find("#category").value, userId:Meteor.userId())
      watches.insert
        watched: false
        category: t.find("#category").value
        userId:  Meteor.userId()
        contact: Meteor.user().emails[0]['address']
 
        
  'click .remove_watch': (e,t) ->
    e.preventDefault()
    watches.remove e.currentTarget.id