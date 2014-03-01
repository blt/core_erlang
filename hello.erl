-module(hello).

-export([main/0]).

main() ->
    blast_space(),
    QuotedAtom = 'NotUsed',
    UnquotedAtom = not_used,
    io:format("This is quoted ~p and this is not ~p~n", [QuotedAtom, UnquotedAtom]).

blast_space() ->
    {ok, Socket} = gen_udp:open(0),
    ok = gen_udp:send(Socket, {127,0,0,1}, 1987, <<"see this binary"/utf8, 1:16/integer>>).
