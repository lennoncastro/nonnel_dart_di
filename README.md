A ridiculous dependency injection package for dart applications.

## Features
Create and instanciate dependencies.
Create and instanciate name dependencies.

## Getting started

#### Install nonnel

    dart pub global activate nonnel

Consider adding the `dart pub global run` executables directory to your path.
See
[Running a script from your PATH](https://dart.dev/tools/pub/cmd/pub-global#running-a-script-from-your-path)
for more details.

## Usage
First, import `di_utils.dart`:<br /> 
`import 'di_utils.dart';`

Then, create a factory (instance) for a dependency that you need:<br />
`factory(A());`

Now, we can use an `A` instance in another dependency using the `inject<A>()` method:<br />
`factory(B(inject<A>()));`

So, we can create named dependencies as below:<br />
`factory(D(), named: 'tchubaruba');`

... and get it passing its name's as a parameter:<br />
`inject(named: 'tchubaruba');`

 We can create any factories and inject depencies in it: <br />
  `factory(
    F(
      inject(named: 'tchubaruba'),
      inject<A>()
    )
  );`

## Modules
You can check how create module files in `example/module.example.dart`: 

## Additional information
TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.