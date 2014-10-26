Feature: as a user interested in receiving nonsense text messages, when a cron job kick in, I will be notified of the weather on the other side of the globe!

  Scenario: Happy path
    When I run `txt-weather`
    Then the output should contain:
    """
    [{"id":1,"email":"asd","created_at":"2014-10-25T23:16:35.201Z","updated_at":"2014-10-25T23:16:35.201Z","phone":"1.1","weather":true,"latitude":1.2,"longitude":null}]
    """  
