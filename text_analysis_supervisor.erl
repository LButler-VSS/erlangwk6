-module(text_analysis_supervisor).
-behaviour(supervisor).

%% API
-export([start_link/1, start/0, start_in_shell_for_testing/0]).
-export([init/1]).

start() ->
    spawn(fun() ->
        supervisor:start_link({local, ?MODULE}, ?MODULE, _Arg = [])
    end).

start_in_shell_for_testing() ->
    {ok, Pid} = supervisor:start_link({local, ?MODULE}, ?MODULE, _Arg = []),
    unlink(Pid).

start_link(_Arg) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init(_Args) ->
    Services = [{lcount, letter_count}, {wcount, word_count}, {perm_it, permutation}],

    {ok, 
        {
            {one_for_one, 3, 10},
                [{Uid,{M, start_link, []},permanent,10000,worker,[M]} || {Uid,M}<-Services]
            }}.

