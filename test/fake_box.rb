require 'fakeweb'

module Edboxra
  class FakeBox
    VERSION_1_SNIPPET = <<-eos
      <script src="include/gen3.15/PageableLayoutView.js" type="text/javascript"></script>
      <input type="hidden" name="__K" id="__K" value="Ikc8StJJiJ2Pq/Dl+iUz3MFzk6qnL7mz6hFFkn5LtZM=" />
      <table height="95%" width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
      <td valign="top" align="center">
    eos

    VERSION_2_SNIPPET = <<-eos
      </script>
      <script src="/gen2.0.2/Scripts/s_code.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.buttonset.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.ministorefinder.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/jquery.bt.min-cust.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.basictooltip.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.slideshow.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.trailerplayer.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.newreleases.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.facebook.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.redblog.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.newsletter.js" type="text/javascript"></script><script type="text/javascript">rb.validation.init({"required":"This is a required field","cvv":"Invalid Cvv","password":"This is not a valid password, use 6-12 characters","email":"This is not a valid email","zip":"Invalid ZIP","phoneUS":"Please enter a valid phone number"})
      rb.api.url = '/'; rb.api.key = 'uFyVRI4STRLYVcsJY2zC92etFBe6N/ef19yTBpaRipY=';</script><script type="text/javascript">$(document).ready(function() {rb.component.register('welcome0', rb.widget.welcome, {"loginUrl":"https://www.redbox.com/register?ReturnUrl=http%3a%2f%2fwww.redbox.com%2f","authUrl":["/account"],"rootUrl":"http://www.redbox.com","defaultUrl":"http://www.redbox.com","webAccountID":0,"firstName":"","urlPath":"/","type":"welcome","id":"welcome0","clientText":{"Welcome":"Welcome to redbox!","Hi":"Hi, {0}!","DialogTitle":"Welcome/Create an account"}});
      rb.component.register('shoppingsession0', rb.widget.shoppingsession, {"cartUrl":"https://www.redbox.com/cart","showBlurayWarning":true,"maxItems":5,"data":{"session":{"storeRef":null,"items":[]}},"urlPath":"/","type":"shoppingsession","id":"shoppingsession0","clientText":{}});
      $('.jqbutton').button();
      rb.rec.Omn.Reco
    eos

    def self.fakeout_version_1
      FakeWeb.allow_net_connect = false
      FakeWeb.register_uri(:get, "http://www.redbox.com", :body => VERSION_1_SNIPPET)
    end

    def self.fakeout_version_2
      FakeWeb.allow_net_connect = false
      FakeWeb.register_uri(:get, "http://www.redbox.com", :body => VERSION_2_SNIPPET)
    end
  end
end
