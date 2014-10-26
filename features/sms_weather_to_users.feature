Feature: as a user interested in receiving nonsense text messages, when a cron job kick in, I will be notified of the weather on the other side of the globe!

  @vcr
  Scenario: Happy path
    When I run `txt-weather`
    Then a text message should be sent to "07590389430" stating "It is 62.7 degrees and Mostly Cloudy" 
