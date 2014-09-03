



Template.navbar.categories = ->
  categories



Template.navbar.events
  'click .choose_category': (e,t) ->
    e.preventDefault()
    Session.set('current_category', _.find(categories, (category) -> category is e.currentTarget.id))

