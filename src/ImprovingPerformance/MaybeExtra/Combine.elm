module ImprovingPerformance.MaybeExtra.Combine exposing (main)

import Benchmark exposing (Benchmark, describe)
import Benchmark.Runner exposing (BenchmarkProgram, program)


combine : List (Maybe a) -> Maybe (List a)
combine =
    List.foldr (Maybe.map2 (::)) (Just [])


combineNew : List (Maybe a) -> Maybe (List a)
combineNew list =
    combineNewHelp list []


combineNewHelp : List (Maybe a) -> List a -> Maybe (List a)
combineNewHelp list acc =
    case list of
        head :: tail ->
            case head of
                Just a ->
                    combineNewHelp tail (a :: acc)

                Nothing ->
                    Nothing

        [] ->
            Just (List.reverse acc)


suite : Benchmark
suite =
    let
        tenOks =
            [ Just 2, Just 7, Just 3, Just 2, Just 4, Just 7, Just 4, Just 8, Just 6, Just 1 ]

        withError =
            [ Just 2, Nothing, Just 3, Just 2, Just 4, Just 7, Just 4, Just 8, Just 6, Just 1 ]
    in
    describe "Maybe.Extra.combine"
        [ Benchmark.compare "10 Justs"
            "List.foldlr"
            (\() -> combine tenOks)
            "Recursion"
            (\() -> combineNew tenOks)
        , Benchmark.compare "with error"
            "List.foldlr"
            (\() -> combine withError)
            "Recursion"
            (\() -> combineNew withError)
        ]


main : BenchmarkProgram
main =
    program suite
