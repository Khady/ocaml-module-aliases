open Ocamlbuild_plugin

let explicit_depends file depends =
  let depends_file = file ^ ".depends" in
  let depends_file_contents = file ^ ": " ^ (String.concat " " depends) ^ "\n" in
  let rule_name = depends_file ^ " is empty" in
  rule rule_name
    ~prod:depends_file
    (fun env builder ->
      Echo ([depends_file_contents], depends_file)
    )
let before_rules () =
  explicit_depends "mylib.mli" []

let () = dispatch (function
    | Before_rules -> before_rules ()
    | _ -> ())
