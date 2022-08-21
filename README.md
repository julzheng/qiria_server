# QiriaServer

The repository above is organized using a mix of DDD and Modified Explicit Architecture, of which you can read in this [article](https://julianzheng.com/2022/06/17/applying-the-concept-of-ddd-and-slightly-modified-explicit-archicture-using-elixir/)



📝 **TO DO**

- ✅ BDD layer for User Acceptance Testing
- ✅ Domain + Application layer testing

## How to run
1. You need to have MariaDB installed, and adjust the credentials on config/dev.secret.exs

> mix ecto.migrate

2. This command will scaffold the necessary db and table for the app

> mix run --no-halt

3. Running the above command will spawn two server, REST & GraphQL

## How to test
> MIX_ENV=test mix test

Running the above command will run the Unit test, Integration test & BDD test.
