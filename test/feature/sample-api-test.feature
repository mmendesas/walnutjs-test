Feature: API test

    @simple_api
    Scenario: Load Variables using params
        Given user stores the following list of variables:
            | "base_url" | "${params.[$.default.base_url]}" |
            | "user"     | "${params.[$.default.user]}"     |
        And user prints the message 'my base url --> ${vars.base_url}' to console

    @simple_api
    Scenario: User wants to make a simple GET
        Given (api) user creates a GET request to 'https://httpbin.org/get'
        And (api) user will send and accept JSON
        When (api) user sends the request
        Then (api) the response status should be '200'
        And (api) the JSON response key '$..headers.Host' should have value equals to 'httpbin.org'

    @simple_api
    Scenario: User wants to make a GET with parameters
        Given (api) user creates a GET request to 'https://httpbin.org/get'
        And (api) user will send and accept JSON
        And (api) user add the following parameters to request:
            | mteste | 123 |
        When (api) user sends the request
        Then (api) the response status should be '200'
        And (api) the JSON response key '$..headers.Host' should have value equals to 'httpbin.org'

    @simple_api
    Scenario: I want to make a simple request with XML
        Given (api) user creates a GET request to 'https://httpbin.org/xml'
        And (api) user will send and accept XML
        When (api) user sends the request
        Then (api) the response status should be '200'
        And (api) the XML response key '(//title)[1]' should have value equals to 'Wake up to WonderWidgets!'

    @simple_api
    Scenario: I want to make a simple POST request
        Given (api) user creates a POST request to 'https://httpbin.org/post'
        And (api) user will send and accept JSON
        And (api) user add the following value to BODY request:
            """
            { "mteste": "groselha"}
            """
        When (api) user sends the request
        Then (api) the response status should be '200'
        And (api) the JSON response key '$..headers.Host' should have value equals to 'httpbin.org'
        And (api) the JSON response key '$..json.mteste' should have value equals to 'groselha'



    @simple_api
    Scenario: I want to make a simple POST request using var inside body
        Given (api) user creates a POST request to 'https://httpbin.org/post'
        And (api) user will send and accept JSON
        And (api) user add the following value to BODY request:
            """
            { "mteste": "${vars.user}"}
            """
        When (api) user sends the request
        Then (api) the response status should be '200'
        Then (api) the JSON response key '$..json.mteste' should have value equals to '${vars.user}'