Feature: as a user interested in receiving nonsense text messages, when a cron job kick in, I will be notified of the weather on the other side of the globe!

  Scenario: Happy path
    When I run `txt-weather`
    Then the output should contain:
    """
    some advice
    """  
