# npl-starter

Starter project intended to be a quick start for writing NPL.

## Installation

Clone the project using:

```
git clone git@github.com:NoumenaDigital/npl-starter.git
```

Install the [NPL-Dev](https://plugins.jetbrains.com/plugin/22954-noumena-protocol-language-npl-) plugin in IntelliJ.

In IntelliJ, go to `File`, `Open...`, navigate to the directory, and simply open it. Once imported, right-click on the 
folder `src/main/npl`, go to `Mark directory as` and select `Sources Root`. Similarly mark `src/main/test` as 
`Test Sources Root`.

## Execution

Tests can be run in IntelliJ using the run actions in test files, in file gutters or by using a right-click menu.

Tests can be automatically run using `mvn test` (requires Maven) on the command line.

You should now be able to start programming NPL!

## In details

### Setup check

To ensure your development environment is ready, tests provided in the project should pass.
The setup can be tested by running a test in the `src/test/npl/seed/test_iou.npl` file.

When clicking on the green arrow next to a test, select run all tests or run test in the current file.
Tests should execute and all should pass. If so, your development environment is ready.

The plugin also indicates syntax errors, allows for more detailed tests results and debug your code.
A visualisation of protocols in a PlantUML diagram, and the state machine is also available.

### Implementation

The code in the `npl-starter` repository illustrate the settlement of a debt, also referred to as IOU, against a car.
When the car is transferred, an IOU issued by the first car owner is forgiven.

This example can help you get familiar with the key concepts of NPL like protocols and state machines.
To implement your own use-case, you can create new folders and files in the `src/main/npl` folder.

The [NOUMENA documentation](https://documentation.noumenadigital.com/language/) provides more details about the language.

### Run your code

In the `npl-starter` project, some functions without parameters are grouped in the `src/main/npl/processes/demo.npl` file.
These functions can be run or debugged from the file, by clicking on `Running function in a new sandbox session` from the file gutter.

Test are located in `src/test/npl/objects/test_iou.npl` and can be run or debugged in a similar manner.

From the command line, tests can be run with the maven plugin: `mvn clean test`

### Support

For any question, reach out to us at [info@noumenadigital.com](mailto:info@noumenadigital.com).

What interaction will you be modelling next?
