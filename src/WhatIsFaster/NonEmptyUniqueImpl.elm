module WhatIsFaster.NonEmptyUniqueImpl exposing (main)

import Benchmark exposing (Benchmark, describe)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import NonEmpty as NL exposing (NonEmpty)


suite : Benchmark
suite =
    let
        tenItems : Maybe (NonEmpty Int)
        tenItems =
            List.range 1 5
                |> List.append (List.reverse <| List.range 1 5)
                |> NL.fromList

        thousandItems : Maybe (NonEmpty Int)
        thousandItems =
            List.range 1 500
                |> List.append (List.reverse <| List.range 1 500)
                |> NL.fromList
    in
    describe "NonEmpty unique function implementations"
        [ Benchmark.compare "10 items"
            "foldl"
            (\() -> Maybe.map NL.uniqueFoldl tenItems)
            "uniqueHelp"
            (\() -> Maybe.map NL.uniqueWithHelper tenItems)
        , Benchmark.compare "1000 items"
            "foldl"
            (\() -> Maybe.map NL.uniqueFoldl thousandItems)
            "uniqueHelp"
            (\() -> Maybe.map NL.uniqueWithHelper thousandItems)
        ]


main : BenchmarkProgram
main =
    program suite
