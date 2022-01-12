Feature: List Movies
As an user I expect to see all available movies even if my device is not connected
to the internet

    @positive
    Scenario: Device connected to the internet on app's first launch
    Given my device is connected to the internet
    When I open my app
    Then the movies list should be loaded
    And I should be able to click a movie tile to see it's details
    And the retrieved data shold be storaged

    @positive
    Scenario: Device not connected with data cached
    Given my device is not connected to the internet
    But my app has movies' data cached
    When I open my app
    Then the cached movies list should be loaded
    And I should be able to click a movie tile to see it's details

    @negative
    Scenario: Device not connected without cache
    Given my device is not connected to the internet 
    And my app has no data cached
    When I open my app
    Then an error should be displayed

    @positive
    Scenario: Device connected to the internet with data cached
    Given my device is connected to the internet
    And movie's data is cached
    When I open my app
    Then firstly cached data should be displayed 
    And network data should be loaded and replace both cache and displayed widgets

    @negative
    Scenario: Invalid cache
    Given my device is not connected to the internet 
    And movie's data is cached
    But it is invalid
    When I open my app
    Then an error page should be displayed
    And invalid cache should be cleaned