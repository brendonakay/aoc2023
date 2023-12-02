open! Imports
open Base

(*let extract_int = function _ -> None | (t : int) -> Some t*)

let number_tr ls =
  (List.fold_left ~f:(fun n e -> (e + n, pow * 10)) ~init:0, 1 ls)

module M = struct
  (* Type to parse the input into *)
  type t = Input of int list list (* Multi-dimensional list of ints *)

  (* Parse the input to type t, invoked for both parts *)
  let parse _inputs =
    _inputs |> String.split_lines
    |> List.map ~f:(fun s -> List.init (String.length s) ~f:(String.get s))
    |> List.map ~f:(fun x -> List.filter_map x ~f:Char.get_digit)
    |> fun x -> Input x

  (* Run part 1 with parsed inputs *)
  let part1 (Input i : t) =
    let answer = i |> List.map ~f:number_tr |> List.fold ~init:0 ~f:( + ) in
    Out_channel.output_string Stdlib.stdout
      (Printf.sprintf "Part 1: %d\n" answer)

  (* Run part 2 with parsed inputs *)
  let part2 _ = ()
end

include M
include Day.Make (M)

(* Example input *)
let example = "1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet"

(* Expect test for example input *)
let%expect_test _ = run example ; [%expect {| |}]
