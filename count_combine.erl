-module(count_combine).
-behaviour(gen_server).

%% API
-export([start/0, stop/0, start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3, for/2]).
-define(SERVER, ?MODULE).
start() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

stop() ->
    gen_server:call(?MODULE, stop).

for(X,Y) -> gen_server:call(?MODULE, {countL,X,Y}).

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

init([]) ->
    {ok, up}.

handle_call({countL,C,Passage}, _From, State) ->
    {reply,
        countL_helper(C,Passage),
        State};

handle_call(stop, _From, State) ->
    {stop, normal, stopped, State};

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

countL_helper(C,Passage) ->
    Occurences = [ X || X <- Passage, X == C],
    length(Occurences).
