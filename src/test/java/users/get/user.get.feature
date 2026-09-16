Feature: Plan de pruebas - CRUD usuarios (simulado con JSONPlaceholder)
  Background:
    * def baseUrl = 'https://jsonplaceholder.typicode.com'
    * url baseUrl
    * configure headers = { "Content-Type": "application/json; charset=UTF-8" }

  # ---------- GET ----------
  Scenario: GET /users -> 200 (simulado)
    Given path 'users'
    When method get
    Then status 200
    And match response[0] contains { id: '#number' }

  # ---------- POST ----------
  Scenario: POST /users -> 201 (simulado)
    * def payload = { name: 'morpheus', job: 'leader' }
    Given path 'users'
    And request payload
    When method post
    Then status 201
    And match response contains { name: 'morpheus', job: 'leader' }

  # ---------- PUT ----------
  Scenario: PUT /users/{id} -> 200 (simulado)
    * def id = 1
    * def updatePayload =
    """
    {
      name: "morpheus",
      job: "zion resident"
    }
    """
    Given path 'users', id
    And request updatePayload
    When method put
    Then status 200
    And match response contains { name: 'morpheus', job: 'zion resident' }
    And match response.name == updatePayload.name

  # ---------- DELETE ----------
  Scenario: DELETE /users/{id} -> 200 o 204 (simulado)
    Given path 'users', 1
    When method delete
    Then match responseStatus == 200 || responseStatus == 204
  # Si devuelve 200, típicamente retorna un objeto vacío {}
  # Si devuelve 204, no hay body
    * if (responseStatus == 200) karate.match(response, {}) == true