$ ->
  class Lookup
    constructor: ->
      @bind_lookup_button()

    bind_lookup_button: ->
      $("#lookup").submit =>
        $(".js-status").addClass("hidden")
        @lookup_ip_address()
        false

    lookup_ip_address: ->
      data = { ip_address: $("#ip_lookup").val() }
      $.ajax
        type: 'GET'
        data: data
        url: $("#js-lookup-url").data("url")
        contentType: "json"
        success: (data) =>
          if data.whitelisted
            $(".js-status.text-success").removeClass("hidden")
          else
            $(".js-status.text-danger").removeClass("hidden")
  new Lookup()
