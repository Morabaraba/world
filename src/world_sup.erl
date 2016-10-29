-module(world_sup).

-behaviour(supervisor).

-export([start_link/0, init/1]).

start_link() -> supervisor:start_link({local, ?MODULE}, ?MODULE, noargs).

init(noargs) ->
  SupFlags = #{ strategy  => one_for_one
              , intensity => 100 % restarts in ...
              , period    => 1   % second
              },
  ChildSpecs = [#{ id      => dodos_sup
                 , start   => {animals_sup, start_link, [dodos]}
                 , restart => transient
                 }
              , #{ id      => cockroaches_sup
                 , start   => {animals_sup, start_link, [cockroaches]}
                 , restart => permanent
                 }
                ],
   {ok, {SupFlags, ChildSpecs}}.
