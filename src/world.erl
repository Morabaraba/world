-module(world).

-behaviour(application).

-export([start/0, start/2, stop/0, stop/1]).
-export([add_dodos/1, add_cockroaches/1, kill_dodos/0, kill_cockroaches/0]).


start() -> application:ensure_all_started(?MODULE).

stop() -> application:stop(?MODULE).

start(_StartType, _StartArgs) -> world_sup:start_link().

stop(_State) -> ok.


add_dodos(N) -> add_animals(N, dodos).

add_cockroaches(N) -> add_animals(N, cockroaches).

add_animals(0, _) -> ok;
add_animals(N, Sup) ->
  supervisor:start_child(Sup, []),
  add_animals(N-1 ,Sup).


kill_dodos() -> kill_all(dodos).

kill_cockroaches() -> kill_all(cockroaches).

kill_all(Sup) ->
  [exit(Animal, kill) || {_, Animal, _ , _} <- supervisor:which_children(Sup)].
