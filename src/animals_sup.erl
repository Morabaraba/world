-module(animals_sup).

-behaviour(supervisor).

-export([start_link/1, init/1]).

start_link(Name) -> supervisor:start_link({local, Name}, ?MODULE, Name).

init(Name) ->
  SupFlags = #{ strategy  => simple_one_for_one
              , intensity => 5 % restarts in ...
              , period    => 1 % second
              },
  ChildSpecs = [#{ id      => animal
                 , start   => {animal, start_link, [Name]}
                 , restart => permanent
                 }
                ],
   {ok, {SupFlags, ChildSpecs}}.
