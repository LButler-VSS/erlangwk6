-module(text_analysis).
-export([count/2]).


count(Passage, Char) ->
    String = lists:flatten(Passage),                                                                                                                                                          
    F = fun(C, Count) when C=:=Char-> Count + 1;
         (_, Count)              -> Count
      end,
    lists:foldl(F, 0, String).