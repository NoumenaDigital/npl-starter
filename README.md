# npl-starter

Starter project intended to illustrate key aspects of NPL and provide a quick start for writing and deploying NPL.

This project mirrors aspects of the 
[standard NPL project structure](https://documentation.noumenadigital.com/tracks/creating-project/#understanding-the-project-structure), 
with the exception that `src` appears here at (module) top level. In addition, this project provides a `pom.xml` to 
allow building and testing with Maven.

## Installation

If you are developing locally with an IDE (IntelliJ, VS Code, Cursor, ...):

- Install the [NPL CLI](https://documentation.noumenadigital.com/runtime/tools/build-tools/cli/).
- Install the [NPL-Dev plugin](https://documentation.noumenadigital.com/language/tools/) corresponding to your IDE.
- Via the command shell, execute the git clone command
    ```shell
    git clone git@github.com:NoumenaDigital/npl-starter.git
    ```
    OR create a simple local copy of that project using the NPL CLI:
    ```shell
    npl init --projectDir my-npl-starter --templateUrl https://github.com/NoumenaDigital/npl-starter/archive/refs/heads/iou-bare.zip
    ```

If you wish to use GitHub Codespaces instead, make sure you are logged into GitHub, open this project from the 
`iou-bare` branch of the [npl-starter repository](https://github.com/NoumenaDigital/npl-starter/tree/iou-bare), and 
click on the `Use this template` button top right. The NPL CLI, docker and the VS Code NPL-Dev extension will 
automatically be installed for you in the Codespace.

## Checking the installation

Tests can be automatically run using `npl test` (requires the NPL CLI) or `mvn clean test` (requires Maven) on the 
command line, from the root of the project.

You should now be able to start programming NPL!

## Understanding the example

The code in the `iou-bare` branch of the `npl-starter` repository illustrate the settlement of a debt, also referred to 
as IOU, with partial or complete payment and payment confirmation logic.

This example can help you get familiar with the key concepts of NPL like protocols and state machines.
To implement your own use-case, you can create new folders and files in the `src/main/npl` folder.

The [NOUMENA documentation](https://documentation.noumenadigital.com/language/) provides more details about the 
language.

## Developing with IntelliJ

As explained in the [Installation](#installation) section above, you have various options to start using and developing 
on top of this example: GitHub Codespaces or locally with an IDEA (IntelliJ, VS Code, Cursor, ...). The 
[NPL-Dev plugin](https://documentation.noumenadigital.com/language/tools/) for IntelliJ currently offers the most 
comprehensive set of features to support development.

In IntelliJ, go to `File`, `Open...`, navigate to the directory, and simply open it. Once imported, right-click on the 
folder `src/main/npl`, go to `Mark directory as` and select `Sources Root`. Similarly mark `src/main/test` as 
`Test Sources Root`.

### Checking the setup

To ensure your development environment is ready, tests provided in the project should pass.
The setup can be tested by running a test in the `src/test/npl/objects/test_iou.npl` file.

When clicking on the green arrow next to a test, select run all tests or run test in the current file.
Tests should execute and all should pass. If so, your development environment is ready.

The plugin also indicates syntax errors, allows for more detailed tests results and debug your code.
A visualisation of protocols in a PlantUML diagram, and the state machine is also available.

### Running your NPL code in intelliJ

In the `npl-starter` project, some functions without parameters are grouped in the `src/main/npl/processes/demo.npl` 
file. These functions can be run or debugged from the file, by clicking on `Running function in a new sandbox session` 
from the file gutter.

The tests located in `src/test/npl/objects/test_iou.npl` can be run or debugged in a similar manner.

## Deploying your code and interacting with the NPL application

This project also provides `docker-compose.yml` and `.npl/deploy.yml` configuration files to deploy the NPL code to an 
NPL Runtime running locally in `DEV_MODE`. For more information on this, as well as deployments to NOUMENA Cloud, please
refer to the documentation [Starter tracks](https://documentation.noumenadigital.com/tracks/).

Below are some steps to get your started from command line on Unix-based systems (Linux, MacOS, GitHub Codespaces) and 
Windows with WSL.

Start the NPL Runtime in DEV_MODE with:

```shell
docker compose up -d --wait
```

Deploy the NPL code with:

```shell
npl deploy --clear --sourceDir src/main
```

If you wish to interact with the deployed code using a swagger UI, open your browser and navigate to 
`http://localhost:12000`. Under `Select a definition`, pick `NPL Application - ...` to see the available endpoints. 
Under `Authorize`, select `oidc (OAuth2, password)` and provide username and password as indicated for the commandline 
instructions below. `client_id` and `client_secret` can be left empty.

If you prefer to interact with the deployed code on the command line, follow the steps below.

Authenticate with the embedded OIDC server as user alice and fetch a token with:

```shell
export ACCESS_TOKEN_ALICE=$(curl -s 'http://localhost:11000/token' \
    -d 'username=alice' \
    -d 'password=password123' \
    -d 'grant_type=password' | \
    jq -r .access_token)
```

If you do not have `jq` installed, extract the token by other means from the JSON response.

Create a new IOU instance between `alice` and `bob` (identified by their emails), for an amount of `100`, with:

```shell
export INSTANCE_ID=$(curl -s 'POST' \
  'http://localhost:12000/npl/objects/iou/Iou/' \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $ACCESS_TOKEN_ALICE" \
  -H 'Content-Type: application/json' \
  -d '{
        "initialDebt": 100,
        "@parties": {
          "borrower": {
            "claims": {
              "email": [
                "alice@example.com"
              ]
            }
          },
          "lender": {
            "claims": {
              "email": [
                "bob@example.com"
              ]
            }
          }
        }
      }' | \
  jq -r '."@id"')
```

To control as part of the deployed code what claims can be bound to the IOU parties, use 
[Party Automation](https://documentation.noumenadigital.com/language/concepts/authorization/PartyAutomation/).

Inspect that IOU as user `alice`, using the token fetched above, with:

```shell
curl -X GET "http://localhost:12000/npl/objects/iou/Iou/$INSTANCE_ID/" \
  -H "Authorization: Bearer $ACCESS_TOKEN_ALICE"
```

As user `alice`, claim a payment of `30` towards the IOU instance created above, with:

```shell
curl -X 'POST' \
  "http://localhost:12000/npl/objects/iou/Iou/$INSTANCE_ID/pay" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $ACCESS_TOKEN_ALICE" \
  -H 'Content-Type: application/json' \
  -d '{
    "amount": 30
  }'
```

Fetch an access token for user `bob` with:

```shell
export ACCESS_TOKEN_BOB=$(curl -s 'http://localhost:11000/token' \
    -d 'username=bob' \
    -d 'password=password123' \
    -d 'grant_type=password' | \
    jq -r .access_token)
```

List all IOU instances user `bob` has at least read access to, with:

```shell
curl -X GET http://localhost:12000/npl/objects/iou/Iou/ \
  -H "Authorization: Bearer $ACCESS_TOKEN_BOB"
```

As user `bob`, confirm receipt of the payment reported by `alice`on the IOU instance, with:

```shell
curl -X 'POST' \
  "http://localhost:12000/npl/objects/iou/Iou/$INSTANCE_ID/confirmPayment" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $ACCESS_TOKEN_BOB"
```

Fetch an access token for user `eve` with:

```shell
export ACCESS_TOKEN_EVE=$(curl -s 'http://localhost:11000/token' \
    -d 'username=eve' \
    -d 'password=password123' \
    -d 'grant_type=password' | \
    jq -r .access_token)
```

Check that user `eve` has no access to the IOU instance created above, with:

```shell
curl -X GET http://localhost:12000/npl/objects/iou/Iou/ \
  -H "Authorization: Bearer $ACCESS_TOKEN_EVE"
```

Now, as user `alice` create a second IOU instance between `alice` and a party defined with `company: Noumena Digital` 
and `groups: finance` claims. When doing so, make sure `alice`'s access token has not expired, or generate a new one. 
Then, query the NPL API with:

```shell
export INSTANCE_ID_TWO=$(curl -s 'POST' \
  'http://localhost:12000/npl/objects/iou/Iou/' \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $ACCESS_TOKEN_ALICE" \
  -H 'Content-Type: application/json' \
  -d '{
        "initialDebt": 100,
        "@parties": {
          "borrower": {
            "claims": {
              "email": [
                "alice@example.com"
              ]
            }
          },
          "lender": {
            "claims": {
              "company": [
                "Noumena Digital"
              ],
              "groups": [
                "finance"
              ]
            }
          }
        }
      }' | \
  jq -r '."@id"')
```

Check that user `frank` defined among 
[pre-seeded users in the embedded OIDC](https://documentation.noumenadigital.com/runtime/deployment/configuration/Engine-Dev-Mode/#embedded-oidc-and-seeded-users), 
who has the required claims, can see that IOU instance, while user `peggy` cannot.

Note that `alice`can create IOU instances with `borrower` claims other than her user claims, unless
[Party Automation](https://documentation.noumenadigital.com/language/concepts/authorization/PartyAutomation/) rules are 
added the NPL code deployed.

## Support

For any question, join the [NOUMENA Community](https://community.noumenadigital.com/) or reach out to us at 
[info@noumenadigital.com](mailto:info@noumenadigital.com).

What interaction will you be modelling next?
