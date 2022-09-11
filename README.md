# nonnel_dart_di
A ridiculous dependency injection package for dart applications.

## How to use it
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
