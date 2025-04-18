(* Reads a list of integers from input *)
(* Uses recursion to collect 'count' number of inputs *)
let read_numbers count =
  let rec aux acc i =
    if i = count then List.rev acc
    else aux (read_int () :: acc) (i + 1)
  in
  aux [] 0

(* Calculates the mean (average) of the numbers *)
(* Algorithm: Uses fold_left to sum all elements, then divides by list length *)
let compute_mean numbers =
  let total_sum = List.fold_left (fun acc x -> acc + x) 0 numbers in
  float total_sum /. float (List.length numbers)

(* Calculates the median (middle value) of the sorted numbers *)
(* Algorithm: Sorts list, then for odd length takes middle element, for even averages two middle *)
let compute_median numbers =
  let sorted_numbers = List.sort compare numbers in
  let count = List.length sorted_numbers in
  if count mod 2 = 1 then float (List.nth sorted_numbers (count / 2))
  else
    let first_middle = List.nth sorted_numbers (count / 2 - 1) in
    let second_middle = List.nth sorted_numbers (count / 2) in
    (float first_middle +. float second_middle) /. 2.0

(* Calculates the mode (most frequent number(s)) *)
(* Algorithm: Sorts list, recursively counts frequencies in sorted list, 
   tracks max frequency and collects numbers with that frequency *)
let compute_mode numbers =
  let sorted_numbers = List.sort compare numbers in
  let rec find_modes max_frequency mode_values current_frequency current_number lst =
    match lst with
    | [] -> 
        if current_frequency > max_frequency then [current_number]
        else if current_frequency = max_frequency then current_number :: mode_values
        else mode_values
    | hd :: tl ->
        if hd = current_number then
          find_modes max_frequency mode_values (current_frequency + 1) current_number tl
        else
          let new_modes =
            if current_frequency > max_frequency then [current_number]
            else if current_frequency = max_frequency then current_number :: mode_values
            else mode_values
          in
          find_modes (max max_frequency current_frequency) new_modes 1 hd tl
  in
  match sorted_numbers with
  | [] -> []
  | hd :: tl -> find_modes 0 [] 1 hd tl

(* Main function to read input and display results *)
let () =
  print_string "Enter the number of elements: ";
  let count = read_int () in
  print_string "Enter the elements: ";
  let numbers = read_numbers count in
  Printf.printf "Mean: %.2f\n" (compute_mean numbers);
  Printf.printf "Median: %.2f\n" (compute_median numbers);
  let mode_values = compute_mode numbers in
  print_string "Mode: ";
  List.iter (fun x -> Printf.printf "%d " x) mode_values;
  print_newline ()