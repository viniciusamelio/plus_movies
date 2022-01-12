Feature: Show movie details
As an user I expect to see details about the movie I selected

    @positive
    Scenario: Device connected to the internet
    Given my device is connected to the internet
    When I select a movie tile
    Then movie details should be displayed

    @positive
    Scenario: Device not connected with data cached
    Given my device is not connected to the internet
    But data is cached
    When I select a movie tile
    Then movie details should be displayed

    @negative
    Scenario: Device not connected without cache
    Given my device is not connected to the internet
    And there is no cache storaged
    When I select a movie tile
    Then an error should be displayed