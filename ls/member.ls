$(!->
  ns_member = {}

  ns_member.loading =  ( member )!->
    origin = $( \#member-list )html!

    if member.avatar is undefined or member.avatar is ''
      member.avatar = \./images/avastar_default.png

    social_class =
      * google:   'fa fa-google-plus-square'
        facebook: 'fa fa-facebook-square'
        twitter:  'fa fa-twitter-square'
        instagram:'fa fa-instagram'
        plurk:    'ft-plurk'
        github:   'fa fa-github-square'

    view_social = ''
    for key, value of member.social
      if value isnt ''
        view_social += "<a class=\"social_btn\" href=\"#value\" target=\"_blank\"><i class=\"#{social_class[key]} fa-lg\"></i></a>"

    view = "<div class=\"member\">
              <div class=\"mb-avatar\">
                <a href=\"#{member.avatar}\" target=\"_blank\">
                  <img class=\"pure-img-responsive\" src=\"#{member.avatar}\">
                </a>
              </div>
              <div class=\"mb-info\">
                <h4>#{member.nick} (#{member.id})</h4>
                <span class=\"identity\"> <em>#{member.identity}</em>
                </span>
                <h5 class=\"title\">#{member.title}</h5>
                <p>#{member.content}</p>
                <div style=\"margin-bottom: .5em;\">#view_social</div>
              </div>
            </div>";

    $( \#member-list )html( origin + view )

  ns_member.waterflow = !->
    option =
      * colMinWidth: $( \.member )width!,
        defaultContainerWidth: $( \#member-list )width!,
        autoresize: true

    console.log($( \.member )width!, $( \#member-list )width!)

    $( \#member-list )addClass( \waterfall );
    $( \.waterfall )waterfall( option )

  ns_member.json_loading = !->
    $.getJSON( \./js/member_list.json, ( members )!->
      ns_member.list := members;
      ns_member.list.map(ns_member.loading)
    )
    .done( !->
      ns_member.waterflow!
    )

  ns_member.json_loading!
)
