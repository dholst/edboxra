require 'webmock'

class FakeBox
  VERSION_1_SNIPPET = <<-eos
    <script src="include/gen3.15/PageableLayoutView.js" type="text/javascript"></script>
    <input type="hidden" name="__K" id="__K" value="version_1_key" />
    <table height="95%" width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
    <td valign="top" align="center">
  eos

  VERSION_2_SNIPPET = <<-eos
    </script>
    <script src="/gen2.0.2/Scripts/s_code.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.buttonset.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.ministorefinder.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/jquery.bt.min-cust.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.basictooltip.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.slideshow.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.trailerplayer.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.newreleases.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.facebook.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.redblog.js" type="text/javascript"></script><script src="/gen2.0.2/Scripts/rb.widget.newsletter.js" type="text/javascript"></script><script type="text/javascript">rb.validation.init({"required":"This is a required field","cvv":"Invalid Cvv","password":"This is not a valid password, use 6-12 characters","email":"This is not a valid email","zip":"Invalid ZIP","phoneUS":"Please enter a valid phone number"})
    rb.api.url = '/'; rb.api.key = 'version_2_key';</script><script type="text/javascript">$(document).ready(function() {rb.component.register('welcome0', rb.widget.welcome, {"loginUrl":"https://www.redbox.com/register?ReturnUrl=http%3a%2f%2fwww.redbox.com%2f","authUrl":["/account"],"rootUrl":"http://www.redbox.com","defaultUrl":"http://www.redbox.com","webAccountID":0,"firstName":"","urlPath":"/","type":"welcome","id":"welcome0","clientText":{"Welcome":"Welcome to redbox!","Hi":"Hi, {0}!","DialogTitle":"Welcome/Create an account"}});
    rb.component.register('shoppingsession0', rb.widget.shoppingsession, {"cartUrl":"https://www.redbox.com/cart","showBlurayWarning":true,"maxItems":5,"data":{"session":{"storeRef":null,"items":[]}},"urlPath":"/","type":"shoppingsession","id":"shoppingsession0","clientText":{}});
    $('.jqbutton').button();
    rb.rec.Omn.Reco
  eos

  class << self
    def fakeout_version_1
      setup(VERSION_1_SNIPPET)
    end

    def fakeout_version_2
      setup(VERSION_2_SNIPPET)
    end

    def expect_get(url, response)
      WebMock \
        .stub_request(:get, url) \
        .to_return(:status => 200, :body => response)
    end

    def expect_post(url, content, headers, response)
      WebMock \
        .stub_request(:post, url) \
        .with(:body => content, :headers => headers) \
        .to_return(:status => 200, :body => response)
    end

    private

    def setup(main_page)
      WebMock.reset!
      WebMock.disable_net_connect!
      WebMock \
        .stub_request(:get, "http://www.redbox.com/") \
        .to_return(:status => 200, :body => main_page, :headers => {'Set-Cookie' => 'redboxVersion=foo; expires=Fri, 11-Mar-2011 02:02:51 GMT; path=/; HttpOnly'})
    end
  end
end
