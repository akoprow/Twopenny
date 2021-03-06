/*
 * Twopenny. (C) MLstate - 2011
 * @author Adam Koprowski
**/

package mlstate.twopenny

/**
 * {1 HTML generation for Twopenny pages}
**/

Pages = {{

  unimplemented =
    <>
      Coming soon... stay tuned
    </>

  main_page() =
    ("Twopenny", unimplemented)

  @client show_new_message(~{newmsg}) =
    exec([#msgs -<- Msg.render(newmsg, {new})])

  @client setup_msg_updates(_) =
    chan = Session.make_callback(show_new_message)
    do MsgFactory.subscribe_to_all(chan)
    do debug("subscribing to new messages")
    void

  @client setup_newmsg_box(user)(_) =
    xhtml = WMsgBox.html("msgbox", Msg.create(user, _), MsgFactory.submit)
    exec([#newmsg <- xhtml])

  user_page(user : User.ref) =
    content =
      <>
        <div class="header">
          {User.show_photo({size_px=80}, user)}
          {User.to_string(user)}
        </>
        <div id=#newmsg onready={setup_newmsg_box(user)} />
        <div id=#msgs onready={setup_msg_updates} />
      </>
    ("Twopenny :: {User.to_string(user)}", content)

  label_page(label) =
    ("Twopenny :: {Label.to_string(label)}", unimplemented)

}}

css = [ page_css, msg_css, msg_box_css ]

page_css = css
  body {
    margin: 0px;
  }
  html {
    width: 800px;
    margin: auto;
    height: 100%;
    padding: 15px;
    border-left: 1px dotted black;
    border-right: 1px dotted black;
  }
  .hidden {
    display: none;
  }
  .header .image {
    margin: -15px 0px;
  }
  .header {
    border-top: 1px dotted black;
    border-bottom: 1px dotted black;
    font-variant: small-caps;
    font-size: 20pt;
    height: 50px;
    margin: 30px -16px;
    background: #F8F8F8;
    padding: 0px 15px;
  }
/* marking external links
  a[rel="external"], a.external {
    white-space: nowrap;
    padding-right: 10px;
    background: url('/img/link.png') no-repeat 100% 50%;
    zoom: 1;
  }
*/
