-module(animal).

-behavior(gen_server).

-export([ start_link/1
        , init/1
        , terminate/2
        , code_change/3
        , handle_call/3
        , handle_cast/2
        , handle_info/2
        ]).

start_link(Species) ->
  gen_server:start_link(?MODULE, Species, [{debug, [log, trace]}]).

init(Species) -> {ok, #{species => Species}}.

handle_call(_Msg, _From, State) -> {stop, dead, dead, State}.

handle_cast(_Msg, State) -> {stop, dead, State}.

handle_info(_Info, State) -> {stop, dead, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVersion, State, _Extra) -> {ok, State}.
