open! Imports
open Base

let values =
  [ ("one", "1")
  ; ("two", "2")
  ; ("three", "3")
  ; ("four", "4")
  ; ("five", "5")
  ; ("six", "6")
  ; ("seven", "7")
  ; ("eight", "8")
  ; ("nine", "9")
  ; ("1", "1")
  ; ("2", "2")
  ; ("3", "3")
  ; ("4", "4")
  ; ("5", "5")
  ; ("6", "6")
  ; ("7", "7")
  ; ("8", "8")
  ; ("9", "9") ]

(* Credit to tjdevries solution *)
let values_to_digit str pos =
  List.find_map values ~f:(fun (substr, value) ->
      match String.substr_index ~pos str ~pattern:substr with
      | Some matched when matched = pos -> Some value
      | _ -> None )

(* Loop over string in order and find match *)
let first_match str =
  let map_to_number = values_to_digit str in
  List.range 0 (String.length str)
  |> List.find_map ~f:map_to_number
  |> Option.value_exn

(* Loop over string in reverse order and find match *)
let last_match str =
  let map_to_number = values_to_digit str in
  (* ~stop:`inclusive includes stop value*)
  List.range ~stride:(-1) ~stop:`inclusive (String.length str) 0
  |> List.find_map ~f:map_to_number
  |> Option.value_exn

(* Recursive function to convert parsed characters to the integer *)
let rec convert_int = function
  | [] -> 0
  | [x] -> (x * 10) + x
  | [x; y] -> (x * 10) + y
  | e1 :: _ :: r -> convert_int (e1 :: r)

module M = struct
  (* Type to parse the input into *)
  type t = Input of string list (* Multi-dimensional list of ints *)

  (* Parse the input to type t, invoked for both parts *)
  let parse _inputs = _inputs |> String.split_lines |> fun x -> Input x

  (* Run part 1 with parsed inputs *)
  let part1 (Input i : t) =
    let answer =
      i
      |> List.map ~f:(fun s -> List.init (String.length s) ~f:(String.get s))
      |> List.map ~f:(fun x -> List.filter_map x ~f:Char.get_digit)
      |> List.map ~f:convert_int
      |> List.fold ~init:0 ~f:( + )
    in
    Out_channel.output_string Stdlib.stdout
      (Printf.sprintf "Part 1: %d\n" answer)

  (* Run part 2 with parsed inputs. We only need the first and last match for
     the record row *)
  let part2 (Input i : t) =
    let answer =
      List.fold i ~init:0 ~f:(fun acc line ->
          let first_num = first_match line in
          let second_num = last_match line in
          let number =
            convert_int [Int.of_string first_num; Int.of_string second_num]
          in
          acc + number )
    in
    Out_channel.output_string Stdlib.stdout
      (Printf.sprintf "Part 2: %d\n" answer)
end

include M
include Day.Make (M)

(* Example input *)
let example = "1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet"

(* Expect test for example input *)
let%expect_test _ = run example ; [%expect {| |}]
