$ ->
  class Lookup
    constructor: ->
      @bind_lookup_button()

    bind_lookup_button: ->
      $("#lookup").click =>
        @lookup_ip_address()

    lookup_ip_address: ->
      data = { ip_address: $("#ip_lookup").val() }
      $.ajax
        type: 'GET'
        data: data
        url: $("#js-lookup-url").data("url")
        contentType: "json"
        success: (data) =>
          if data.whitelisted
            $(".js-status").html("The addres IS whitelisted")
          else
            $(".js-status").html("The addres IS NOT whitelisted")
  new Lookup()
