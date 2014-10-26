Feature: as a user interested in receiving nonsense text messages, when a cron job kick in, I will be notified of the weather on the other side of the globe!

  @vcr
  Scenario: Happy path
    When I run `txt-weather`
    Then a text message with following content should be sent:
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <Message>
      <Key>8dc497a757dcadd07faef21f816b67135bd7aef0</Key>
      <SMS>
        <Content>{:summary=&gt;"Mostly Cloudy", :temperature=&gt;62.7}</Content>
        <To>07590389430</To>
        <WrapperID>0</WrapperID>
      </SMS>
    </Message>
    """  
