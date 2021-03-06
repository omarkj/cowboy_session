-module(cowboy_session_sup).
-behaviour(supervisor).
%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(CHILD(I, StartFunc, Restart), {I, StartFunc,
				       Restart,
				       5000,
				       supervisor, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================
init([]) ->
    {ok, {{one_for_one, 10, 5},
	  [?CHILD(cowboy_session_server_sup,
		  {cowboy_session_server_sup, start_link, []},
		  permanent)
	  ]}}.
