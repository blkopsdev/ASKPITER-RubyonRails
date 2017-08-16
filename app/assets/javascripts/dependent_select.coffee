$ ->
  $(document).on 'change', 'select.leader', ->
    leader = $ this
    return unless leader_id = leader.attr('id')

    leader_val = leader.val()
    dependants = $("select[data-leader='#{leader_id}']").not(leader)

    dependants.each ->
      dependant = $ this

      dependant.val('')
      dependant.prop('disabled', true)
      dependant.children().not("option:first[value='']").remove()

      return unless leader_val && dependant_id = dependant.attr('id')

      storages = $ "select.storage[data-owner='#{leader_id}'][data-dependant~='#{dependant_id}']"
      options  = storages.children("optgroup[label='#{leader_val}']").children('option').clone()

      if options.length
        dependant.append options
        dependant.prop('disabled', false)

      true
    true
  true
