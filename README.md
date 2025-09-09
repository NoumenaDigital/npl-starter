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
- Via the command shell, first create a directory and then execute the git clone command
```
git clone git@github.com:NoumenaDigital/npl-starter.git
```

If you wish to use GitHub Codespaces instead, make sure you are logged into GitHub, open this project from the 
[npl-starter repository](https://github.com/NoumenaDigital/npl-starter/), and click on the `Use this template` button 
top right. The NPL CLI, docker and the VS Code NPL-Dev extension will automatically be installed for you in the 
Codespace.

## Checking the installation

Tests can be automatically run using `npl test` (requires the NPL CLI) or `mvn clean test` (requires Maven) on the 
command line, from the root of the project.

You should now be able to start programming NPL!

## Understanding the example

The code in the `npl-starter` repository illustrate the settlement of a debt, also referred to as IOU, against a car.
When the car is transferred, an IOU issued by the first car owner is forgiven.

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

## Deploying your code

This project also provides `docker-compose.yml` and `.npl/deploy.yml` configuration files to deploy the NPL code to an 
NPL Runtime running locally in `DEV_MODE`. For more information on this, as well as deployments to NOUMENA Cloud, please
refer to the [Starter tracks](https://documentation.noumenadigital.com/tracks/).

## Support

For any question, join the [NOUMENA Community](https://community.noumenadigital.com/) or reach out to us at 
[info@noumenadigital.com](mailto:info@noumenadigital.com).

What interaction will you be modelling next?
